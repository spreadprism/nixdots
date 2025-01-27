plugin("L3MON4D3/LuaSnip"):event("VeryLazy"):version("v2.*"):config(function()
	require("luasnip").setup({
		history = true,
		updateevents = "TextChangedI, TextChangedI", -- BUG: nvim-cmp breaks with this setting
	})

	require("luasnip.loaders.from_lua").load({ paths = SNIPPETS_PATH })
end)
