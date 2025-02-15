keybind_group("<leader>t", "task"):register({
	keybind("n", "t", "<cmd>OverseerToggle<cr>", "Open UI"),
	keybind("n", "b", "<cmd>OverseerBuild<cr>", "Build"),
	keybind("n", "r", "<cmd>OverseerRun<cr>", "Run a task"),
	keybind("n", "o", "<cmd>OverseerQuickAction open float<cr>", "Open float last task"),
})
