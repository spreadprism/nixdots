keybind_group("<leader>g", "git"):register({
	keybind("n", "g", "<cmd>Neogit<cr>", "Open Neogit"),
	keybind("n", "b", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle blame current line"),
	keybind("n", "B", "<cmd>BlameToggle<cr>", "Toggle Git blame window"),
	keybind("n", "d", function()
		vim.cmd("Barbecue hide")
		vim.cmd("DiffviewOpen")
	end, "Open Diff view"),
	keybind("n", "q", function()
		vim.cmd("DiffviewClose")
		vim.cmd("Barbecue show")
	end, "Close Diff view"),
})
