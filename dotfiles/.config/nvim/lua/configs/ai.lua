-- TODO: I need to add indicator to lualine
-- TODO: Add multi agent supports
-- TODO: Use https://github.com/milanglacier/minuet-ai.nvim for inline completion

local use_copilot = true
local copilot = plugin("zbirenbaum/copilot.lua")
	:event("VeryLazy")
	:enabled(use_copilot) -- INFO: Don't have the subscription anymore
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

local GetChatAdapter = function()
	if env("GEMINI_API_KEY") ~= nil then
		return "gemini"
	else
		return "copilot"
	end
end
plugin("olimorris/codecompanion.nvim")
	:dependencies({
		copilot,
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	})
	:event("VeryLazy")
	:opts({
		display = {
			diff = {
				provider = "mini_diff",
			},
			chat = {
				window = {
					layout = "float",
					border = "rounded",
					height = 0.8,
					width = 0.8,
				},
			},
		},
		strategies = {
			chat = {
				adapter = GetChatAdapter(),
				keymaps = {
					close = {
						modes = { i = "<C-q>" },
					},
				},
			},
			inline = {
				adapter = GetChatAdapter(),
			},
		},
	})
