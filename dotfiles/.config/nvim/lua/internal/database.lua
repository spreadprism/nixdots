local M = {}

local names = {}

M.add_connection = function(name, url)
	-- insert in array
	local connections = vim.g.dbs or {}
	for _, db in ipairs(connections) do
		if db.name == name then
			db.url = url
			return
		end
	end

	table.insert(connections, { name = name, url = url })
	table.insert(names, name)
	vim.g.dbs = connections
end

M.clear = function()
	local to_delete = {}
	for _, name in ipairs(names) do
		for i, conn in ipairs(vim.g.dbs) do
			if conn.name == name then
				table.insert(to_delete, i)
			end
		end
	end

	for _, i in ipairs(to_delete) do
		table.remove(vim.g.dbs, i)
	end
	names = {}
end

---@class mysqlCfg
---@field user string
---@field password string
---@field host string
---@field port string
---@field database string

---@param name string
---@param cfg mysqlCfg
M.add_mysql_connection = function(name, cfg)
	cfg.user = cfg.user or "root"
	cfg.password = cfg.password or ""
	cfg.host = cfg.host or "127.0.0.1"
	cfg.port = cfg.port or "3306"
	cfg.database = cfg.database or ""
	local url = string.format("mysql://%s:%s@%s:%s/%s", cfg.user, cfg.password, cfg.host, cfg.port, cfg.database)
	M.add_connection(name, url)
end

return M
