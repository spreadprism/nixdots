keybind_group("<leader>c", "Copilot", {
	keybind({ "n", "v" }, "p", "<cmd>CodeCompanion<cr>", "Prompt"),
	keybind("n", "c", "<cmd>CodeCompanionChat Toggle<cr>", "Open Chat"),
	keybind("n", "a", "<cmd>CodeCompanionActions<cr>", "Actions"),
}):register()
