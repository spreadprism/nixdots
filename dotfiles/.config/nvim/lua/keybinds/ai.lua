keybind_group("<leader>a", "AI-assistant", {
	keybind({ "n", "v" }, "p", "<cmd>CodeCompanion<cr>", "Prompt"),
	keybind("n", "c", "<cmd>CodeCompanionChat Toggle<cr>", "Open Chat"),
	keybind("n", "a", "<cmd>CodeCompanionActions<cr>", "Actions"),
}):register()

keybind("i", "<M-l>", function()
	local cmp = require("cmp")
	if cmp.visible() then
		cmp.close()
	end
	require("copilot.suggestion").next()
end, "copilot next"):register()
