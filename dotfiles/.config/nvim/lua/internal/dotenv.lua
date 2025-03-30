local M = {}
local fs = require("internal.fs")

local env = {}

---@return string
M.home = function()
	---@diagnostic disable-next-line: return-type-mismatch
	return os.getenv("HOME")
end

---@param key string
---@return string?
M.get = function(key)
	local val = env[key]
	if val == nil then
		val = os.getenv(key)
	end
	return val
end

M.get_all = function()
	return env
end

---@param key string
---@param val string
M.set = function(key, val)
	env[key] = val
end

M.clear = function()
	env = {}
end

---@param env_files string[] | nil
---@param dir string | nil
M.load_cwd = function(env_files, dir)
	dir = dir or cwd()
	local files = {}
	if env_files ~= nil then
		for _, file in ipairs(env_files) do
			table.insert(files, vim.fs.joinpath(dir, file))
		end
	else
		files = require("internal.fs").list_files(dir, 1, "env") or {}
	end

	for _, file in ipairs(files) do
		M.load_path(file)
	end
end

M.load_path = function(path)
	local file = io.open(path, "r")
	if file == nil then
		return
	end

	for line in file:lines() do
		local key, val = line:match("^([^=]+)=(.*)$")
		M.set(key, val)
	end

	file:close()
end

---@param files string[]
---@param dir string
---@return table<string, string>
M.env_file = function(files, dir)
	local envs = {}
	for _, file in ipairs(files) do
		local path = vim.fs.joinpath(dir, file)
		if not fs.exists(path) then
			goto continue
		end

		local content = io.open(path, "r")
		if content == nil then
			goto continue
		end

		for line in content:lines() do
			local key, val = line:match("^([^=]+)=(.*)$")
			if key ~= nil then
				envs[key] = val
			end
		end
		::continue::
	end

	return envs
end

M.load_table = function(t)
	env = vim.tbl_deep_extend("force", env, t)
end

return M
