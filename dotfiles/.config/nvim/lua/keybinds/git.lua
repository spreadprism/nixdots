keybind_group("<leader>g", "git"):register({
	keybind("n", "g", function()
		vim.cmd("tablast")
		vim.cmd("Neogit")
	end, "Open Neogit"),
	keybind("n", "b", "<cmd>Telescope git_branches<cr>", "search branches"),
	keybind("n", "c", "<cmd>Telescope git_commits<cr>", "search commits"),
	-- keybind("n", "b", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle blame current line"),
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
