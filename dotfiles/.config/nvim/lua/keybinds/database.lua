keybind_group("<leader>v", "vimdadbod"):register({
	keybind("n", "v", function()
		vim.cmd("tabnew")
		vim.cmd("DBUI")
	end, "Open DB tab"),
	keybind("n", "a", "<cmd>DBUIAddConnection<cr>", "Add connection"),
})
