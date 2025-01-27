-- TODO: I need to add indicator to lualine
local copilot = plugin("zbirenbaum/copilot.lua")
	:event("VeryLazy")
	:enabled(true) -- INFO: Don't have the subscription anymore
	:opts({
		suggestion = {
			enabled = true,
			auto_trigger = false,
			keymap = {
				accept = "<M-a>",
				dismiss = "<M-d>",
				next = false,
			},
		},
		panel = { enabled = false },
	})
plugin("echasnovski/mini.diff"):event("VeryLazy")
plugin("olimorris/codecompanion.nvim")
	:dependencies({
		copilot,
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	})
	:event("VeryLazy")
	:opts({})
