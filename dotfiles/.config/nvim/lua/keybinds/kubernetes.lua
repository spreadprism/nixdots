keybind_group("<leader>k", "kubernetes"):register({
	keybind("n", "k", function()
		vim.cmd("tabnew")
		require("kubectl").toggle()
	end, "Open kubernetes panel"),
	keybind("n", "c", "<cmd>Kubectx<cr>", "Select kubectl context"),
	keybind("n", "n", "<cmd>Kubectx<cr>", "Select kubectl namespace"),
})
