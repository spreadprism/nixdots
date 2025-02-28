local diff = plugin("sindrets/diffview.nvim"):event("VeryLazy"):config(function()
	local actions = require("diffview.actions")
	require("diffview").setup({
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
		keymaps = {
			file_panel = {
				["gf"] = function()
					actions.goto_file()
					vim.cmd("tabclose #")
				end,
				["<C-q>"] = function()
					vim.cmd("tabclose")
				end,
				["<leader>gd"] = function()
					vim.cmd("tabclose")
				end,
			},
			view = {
				["<C-q>"] = function()
					vim.cmd("tabclose")
				end,
				["<leader>gd"] = function()
					vim.cmd("tabclose")
				end,
				{
					"n",
					"<M-l>",
					actions.prev_conflict,
					{ desc = "In the merge-tool: jump to the previous conflict" },
				},
				{
					"n",
					"<M-h>",
					actions.next_conflict,
					{ desc = "In the merge-tool: jump to the next conflict" },
				},
				{ "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel." } },
			},
		},
	})
end)
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
