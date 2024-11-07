local diff = plugin("sindrets/diffview.nvim"):event("VeryLazy"):opts({})
plugin("NeogitOrg/neogit")
	:dependencies({
		diff,
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	})
	:cmd("Neogit")
	:opts({
		disable_hint = true,
		integrations = {
			telescope = true,
			diffview = true,
		},
		graph_style = "unicode",
	})
plugin("FabijanZulj/blame.nvim"):event("VeryLazy"):opts({})
plugin("lewis6991/gitsigns.nvim"):event("VeryLazy"):opts({
	current_line_blame_opts = {
		delay = 10,
	},
	current_line_blame_formatter = " | <author>, <author_time:%R>",
})
