local M = {}

---@type Adapter[]
local adapters_configs = {}
---@type table[string, LaunchConfigs]
local launch_configs = {}

---@param adapter Adapter
M.insert_adapter = function(adapter)
	table.insert(adapters_configs, adapter)
end

---@param configs LaunchConfigs
M.insert_launch_configs = function(configs)
	launch_configs[configs.lang] = configs.configs
end

M.init_adapters = function()
	local dap = require("dap")
	for _, adapter in ipairs(adapters_configs) do
		if adapter.init then
			dap.adapters[adapter.name] = adapter.opts
		end
	end
end

-- TODO: Load dap configurations
--- @param ft string | nil
M.init_configurations = function(ft)
	if ft == nil then
		for ft_conf, _ in pairs(launch_configs) do
			M.init_configurations(ft_conf)
		end
	else
		local configs = launch_configs[ft] or {}
		local temp_configs = {}
		for _, config in ipairs(configs) do
			config.name = "(NVIM) " .. config.name
			table.insert(temp_configs, config)
		end
		require("dap").configurations[ft] = vim.list_extend(temp_configs, require("dap").configurations[ft] or {})
	end
end

--- @param ft string | nil
M.refresh_configurations = function(ft)
	if ft == nil then
		require("dap").configurations = {}
	else
		require("dap").configurations[ft] = {}
	end
	M.init_configurations(ft)
end

M.list_adapters_mason = function()
	local adapters = vim.tbl_filter(function(adapter)
		return adapter.mason_install or type(adapter.mason_install) == "string"
	end, adapters_configs)

	return vim.tbl_map(function(adapter)
		if type(adapter.mason_install) == "string" then
			return adapter.mason_install
		else
			return adapter.name
		end
	end, adapters)
end

M.debug_go_test = function()
	local ts = require("dap-go-ts")

	local test = ts.closest_test()

	if test.name == "" or test.name == nil then
		vim.notify("no test found")
		return false
	end

	M.last_testname = test.name
	M.last_testpath = test.package

	local msg = string.format("starting debug session '%s : %s'...", test.package, test.name)
	vim.notify(msg)

	local extra_args = {}
	if M.test_verbose then
		extra_args = { "-test.v" }
	end

	local dap = require("dap")
	local config = {
		type = "go",
		name = test.name,
		request = "launch",
		mode = "test",
		console = "internalConsole",
		program = test.package,
		args = { "-test.run", "^" .. test.name .. "$" },
		buildFlags = "",
		env = {
			GO_LOG = "debug",
		},
	}

	dap.run(config)
end

return M
