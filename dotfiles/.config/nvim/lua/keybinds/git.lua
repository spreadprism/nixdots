keybind_group("<leader>g", "git"):register({
	keybind("n", "g", function()
		vim.cmd("tablast")
		vim.cmd("Neogit")
	end, "Open Neogit"),
	keybind("n", "b", "<cmd>Telescope git_branches<cr>", "search branches"),
	keybind("n", "c", "<cmd>Telescope git_commits<cr>", "search commits"),
	-- keybind("n", "b", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle blame current line"),
	keybind("n", "B", "<cmd>BlameToggle<cr>", "Toggle Git blame window"),
})
