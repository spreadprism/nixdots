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
				next = "<M-l>",
			},
		},
		panel = { enabled = false },
	})
rock("gptlang/lua-tiktoken")
plugin("CopilotC-Nvim/CopilotChat.nvim")
	:dependencies({ copilot, "nvim-lua/plenary.nvim" })
	:event("VeryLazy")
	:enabled(copilot.specs.enabled)
