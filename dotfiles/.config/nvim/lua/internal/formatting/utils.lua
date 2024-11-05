local M = {}

---@type Formatter[]
local formatters = {}

---@param formatter Formatter
M.insert = function(formatter)
	table.insert(formatters, formatter)
end

M.list_formatters_mason = function()
	local f = vim.tbl_filter(
		---@param formatter Formatter
		function(formatter)
			return formatter.install_mason
		end,
		formatters
	)
	---@param formatter Formatter
	local map = vim.tbl_map(function(formatter)
		return formatter.mason_name
	end, f)
	return map
end

M.list_formatters = function()
	return formatters
end

return M
