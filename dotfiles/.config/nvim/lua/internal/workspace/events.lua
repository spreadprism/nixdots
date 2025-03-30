local M = {}
---@param workspace Workspace
---@param pattern table | string
---@param action function | string
---@return Workspace
function M.on_write(workspace, pattern, action)
	if type(pattern) == "string" then
		pattern = { pattern }
	end
	local callback = action
	if type(action) == "string" then
		callback = function()
			require("overseer").run_template({ name = action })
		end
	end
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = workspace.on_save_group_id,
		pattern = pattern,
		callback = callback,
	})
	return workspace
end

return M
