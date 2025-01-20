keybind_group("<leader>r", "requests"):register({
	keybind("n", "r", "<cmd>Rest run<cr>", "run request under cursor"),
	keybind("n", "o", "<cmd>Rest open<cr>", "Open results tab"),
	keybind("n", "l", "<cmd>Rest last<cr>", "Execute last request"),
	keybind("n", "L", "<cmd>Rest logs<cr>", "Edit logs file"),
	keybind("n", "c", "<cmd>Rest cookies<cr>", "Edit cookies file"),
	keybind("n", "s", "<cmd>Rest env select<cr>", "Select .env file"),
})
