local events = require("internal.workspace.events")
local env = require("internal.workspace.env")
local launch = require("internal.workspace.launch")

local M = {}
---@class Workspace
---@field on_save_group_id integer
---@field n_task integer
---@field env_files string[]
M.Workspace = {}
M.Workspace.__index = M.Workspace

---@type Workspace | nil
local instance = nil

---@return Workspace
M.get_workspace = function()
	if instance == nil then
		instance = setmetatable({}, M.Workspace)
		launch.init()
	end
	return instance
end

---@param pattern table | string
---@param action function | string
function M.Workspace:on_write(pattern, action)
	events.on_write(self, pattern, action)
end

function M.Workspace:dotenv(files, dir)
	env.dotenv(self, files, dir)
end

---@param tasks Task | Task[]
function M.Workspace:task(tasks)
	-- if tasks has name and cmd attrs its not an array
	if tasks.name and tasks.cmd then
		tasks = { tasks }
	end
	for _, task in ipairs(tasks) do
		require("internal.workspace.tasks").register_task(self.n_task, task)
		self.n_task = self.n_task + 1
	end
end

---@param ft string
---@param config DapConfig | DapConfig[]
function M.Workspace:launch_config(ft, config)
	if config.name then
		config = { config }
	end
	for _, cfg in ipairs(config) do
		-- BUG: fix
		-- cfg.env = env.GetEnvTable(cfg.env)
		-- print(cfg.env)
		cfg.type = cfg.type or ft
		launch.add_config(cfg)
	end
end

return M
