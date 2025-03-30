local M = {}

local configs = {}

function M.init()
	local dap = require("dap")
	dap.providers.configs["dap.workspace"] = function(bufnr)
		return configs
	end
end

function M.clear()
	configs = {}
end

---@class DapConfig
---@field name string
---@field type string | nil
---@field program string
---@field request string | nil
---@field console string | nil
---@field cwd string | nil
---@field env table<string, string> | nil

---@param cfg DapConfig
function M.add_config(cfg)
	cfg.request = cfg.request or "launch"
	cfg.console = cfg.console or "externalTerminal"
	cfg.cwd = cfg.cwd or cwd()

	table.insert(configs, cfg)
end

return M
