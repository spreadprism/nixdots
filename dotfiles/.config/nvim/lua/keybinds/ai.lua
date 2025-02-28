keybind_group("<leader>a", "AI-assistant", {
	keybind("n", "p", "<cmd>CodeCompanion<cr>", "Prompt"),
	keybind("v", "p", function()
		vim.ui.input({ prompt = "Prompt" }, function(input)
			vim.cmd("'<,'>CodeCompanion " .. input)
		end)
	end, "Prompt"),
	keybind("v", "e", "<cmd>CodeCompanion /explain<cr>", "Explain"),
	keybind("v", "f", "<cmd>CodeCompanion @editor /fix<cr>", "Fix"),
	keybind("v", "t", "<cmd>CodeCompanion @editor /tests<cr>", "Generate tests"),
	keybind("n", "c", "<cmd>CodeCompanionChat Toggle<cr>", "Toggle chat"),
	keybind("n", "a", "<cmd>CodeCompanionActions<cr>", "Actions"),
}):register()

keybind("i", "<M-l>", function()
	local cmp = require("cmp")
	if cmp.visible() then
		cmp.close()
	end
	require("copilot.suggestion").next()
end, "copilot next"):register()
