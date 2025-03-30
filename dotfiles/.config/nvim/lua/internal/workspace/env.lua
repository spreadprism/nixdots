local dotenv = require("internal.dotenv")

local M = {}

---@param workspace Workspace
---@param files string[] | nil
---@param dir string | nil
function M.dotenv(workspace, files, dir)
	if files == nil then
		files = { ".env", ".local.env" }
	end
	if dir == nil then
		dir = cwd()
	end

	local load_env = function()
		dotenv.load_table(dotenv.env_file(files, dir))
	end

	load_env()

	local patterns = {}

	for _, file in ipairs(files) do
		table.insert(patterns, vim.fn.glob(vim.fn.fnamemodify(file, ":p")))
	end

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = workspace.on_save_group_id,
		pattern = patterns,
		callback = load_env,
	})
end

---@param additional table<string, string> | nil
function M.GetEnvTable(additional)
	local all = dotenv.get_all()
	if additional == nil then
		return all
	end
	return vim.tbl_deep_extend("force", all, additional)
end

return M
