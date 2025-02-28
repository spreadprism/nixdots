local diff = plugin("sindrets/diffview.nvim"):event("VeryLazy"):config(function()
	local actions = require("diffview.actions")
	require("diffview").setup({
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
		keymaps = {
			disable_defaults = true,
			view = {
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
				{
					"n",
					"<tab>",
					actions.select_next_entry,
					{ desc = "Open the diff for the next file" },
				},
				{
					"n",
					"<s-tab>",
					actions.select_prev_entry,
					{ desc = "Open the diff for the previous file" },
				},
				{ "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel." } },
				{
					"n",
					"<leader>co",
					actions.conflict_choose("ours"),
					{ desc = "Choose the OURS version of a conflict" },
				},
				{
					"n",
					"<leader>ct",
					actions.conflict_choose("theirs"),
					{ desc = "Choose the THEIRS version of a conflict" },
				},
				{
					"n",
					"<leader>cb",
					actions.conflict_choose("base"),
					{ desc = "Choose the BASE version of a conflict" },
				},
				{
					"n",
					"<leader>ca",
					actions.conflict_choose("all"),
					{ desc = "Choose all the versions of a conflict" },
				},
				{ "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
				{
					"n",
					"<leader>cO",
					actions.conflict_choose_all("ours"),
					{ desc = "Choose the OURS version of a conflict for the whole file" },
				},
				{
					"n",
					"<leader>cT",
					actions.conflict_choose_all("theirs"),
					{ desc = "Choose the THEIRS version of a conflict for the whole file" },
				},
				{
					"n",
					"<leader>cB",
					actions.conflict_choose_all("base"),
					{ desc = "Choose the BASE version of a conflict for the whole file" },
				},
				{
					"n",
					"<leader>cA",
					actions.conflict_choose_all("all"),
					{ desc = "Choose all the versions of a conflict for the whole file" },
				},
				{
					"n",
					"dX",
					actions.conflict_choose_all("none"),
					{ desc = "Delete the conflict region for the whole file" },
				},
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
