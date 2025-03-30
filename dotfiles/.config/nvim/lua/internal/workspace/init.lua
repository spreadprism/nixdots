local M = {}
local workspace = require("internal.workspace.workspace")
local dotenv = require("internal.dotenv")
local launch = require("internal.workspace.launch")

---@return Workspace
M.init = function()
	local w = workspace.get_workspace()

	launch.clear()
	w.on_save_group_id = vim.api.nvim_create_augroup("workspace_on_save", { clear = true })
	w.env_files = {}
	w.n_task = 0
	dotenv.clear()
	return w
end

return M
