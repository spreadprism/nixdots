keybind({ "i", "s" }, "<M-n>", function()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, "Luasnip next/jump"):register()
keybind({ "i", "s" }, "<M-p>", function()
	local ls = require("luasnip")
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, "Luasnip previous"):register()
keybind({ "i", "s" }, "<M-m>", function()
	local ls = require("luasnip")
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, "Luasnip list next"):register()
