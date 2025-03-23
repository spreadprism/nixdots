local M = {}
local dotenv = require("internal.dotenv")
local database = require("internal.database")

---@class Workspace
---@field on_save_group_id integer
---@field env_files string[]
local Workspace = {}
Workspace.__index = Workspace

---@type Workspace | nil
local workspace = nil

---@return Workspace | nil
M.get_workspace = function()
	return workspace
end

---@return Workspace
M.init = function()
	if workspace == nil then
		workspace = setmetatable({}, Workspace)
	else
		print("Refreshing workspace")
	end

	workspace.on_save_group_id = vim.api.nvim_create_augroup("workspace_on_save", { clear = true })
	workspace.env_files = {}
	dotenv.clear()

	return workspace
end

---@param pattern table | string
---@param action function | string
---@return Workspace
function Workspace:on_write(pattern, action)
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
		group = self.on_save_group_id,
		pattern = pattern,
		callback = callback,
	})
	return self
end

---@param env_files string[] | nil
---@param dir string | nil
function Workspace:dotenv(env_files, dir)
	if env_files == nil then
		env_files = { ".env", ".local.env" }
	end
	if dir == nil then
		dir = cwd()
	end

	local load_env = function()
		dotenv.load_table(dotenv.env_file(env_files, dir))
	end

	load_env()

	local patterns = {}

	for _, file in ipairs(env_files) do
		table.insert(patterns, vim.fn.glob(vim.fn.fnamemodify(file, ":p")))
	end

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = self.on_save_group_id,
		pattern = patterns,
		callback = load_env,
	})
end

---@param name string
---@param cfg mysqlCfg
function Workspace:mysql(name, cfg)
	database.add_mysql_connection(name, cfg)
end

return M

-- local database = require("internal.database")
-- local dotenv = require("internal.dotenv")
--
-- local events = {}
-- local dbconn = {}
-- local launch = {}
-- local tasks = {}
--
-- local init = false
-- local init_once = false
-- ---@param pattern table | string
-- ---@param action function | string
-- M.on_write = function(pattern, action)
-- 	if type(pattern) == "string" then
-- 		pattern = { pattern }
-- 	end
-- 	-- TODO: If func we should create an overseer task
-- 	local callback = action
-- 	if type(action) == "string" then
-- 		callback = function()
-- 			require("overseer").run_template({ name = action })
-- 		end
-- 	end
-- 	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 		pattern = pattern,
-- 		callback = callback,
-- 	})
-- end
--
-- M.env = dotenv.get
-- M.dotenv = dotenv.load_cwd
--
-- M.envFile = dotenv.env_file
-- M.mysql_conn = database.add_mysql_connection
--
-- M.launch_config = function(name, type, cfg) end
--
-- return M
