local M = {}

---@class Task
---@field name string
---@field desc string | nil
---@field cmd string | string[]
---@field args string | string[] | nil
---@field cwd string | nil
---@field env table<string, string> | nil

function M.register_task(id, task)
	local overseer = require("overseer")
	local env = require("internal.workspace.env")
	overseer.register_template({
		name = "workspace_t" .. tostring(id),
		builder = function(params)
			return {
				cmd = type(task.cmd) == "table" and task.cmd or { task.cmd },
				args = type(task.args) == "table" and task.args or { task.args },
				name = task.name,
				cwd = task.cwd or cwd(),
				env = env.GetEnvTable(task.env),
			}
		end,
	})
end

return M
