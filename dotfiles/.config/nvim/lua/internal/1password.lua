local M = {}

--- @param vault string
--- @param object string
--- @param field string
--- @return string
M.read = function(vault, object, field)
	return exec(string.format("op read 'op://%s/%s/%s'", vault, object, field))
end

return M
