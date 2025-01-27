local ls = require("luasnip")

-- snippet creator
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
-- repeats a node
local rep = require("luasnip.extras").rep

local fmt = require("luasnip.extras.fmt").fmt
return {
	-- s("req", fmt('local {} = require("{}")', { i(1, "default"), rep(1) })),
	s(
		"req",
		fmt([[local {} = require("{}")]], {
			f(function(import_name)
				local parts = vim.split(import_name[1][1], ".", true)
				return parts[#parts] or ""
			end, { 1 }),
			i(1),
		})
	),
}
