-- keybind("n", "<leader><leader>d", function()
-- 	local dbee = require("dbee")
-- 	dbee.toggle()
-- end, "toggle dbee"):register()

keybind_group("<leader><leader>d", "database", {
	keybind("n", "e", "<cmd>DBUIToggle<cr>", "toggle ui"),
	keybind("n", "a", function()
		-- TODO: Add form inputs
		vim.cmd("DBUIAddConnection")
	end, "Add connection"),
}):register()
