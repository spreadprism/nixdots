keybind_group("<leader>n", "Notifications"):register({
	keybind("n", "d", "<cmd>Noice dismiss<cr>", "Dismiss notifications"),
	keybind("n", "h", "<cmd>NoiceTelescope<cr>", "Notifications history"),
})
