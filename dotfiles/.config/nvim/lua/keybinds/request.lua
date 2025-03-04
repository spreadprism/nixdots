keybind_group("<leader>r", "requests"):register({
	keybind({ "n", "v" }, "r", function()
		require("kulala").run()
	end, "Run the current request"),
	keybind("n", "R", function()
		require("kulala").run_all()
	end, "Run the current request"),
	keybind("n", "l", function()
		require("kulala").replay()
	end, "Run the last request"),
	keybind("n", "O", function()
		require("kulala").open()
	end, "Open float"),
	keybind("n", "o", function()
		-- new tab
		vim.cmd("tabnew")
		require("kulala").scratchpad()
	end, "Open scratchpad"),
	keybind("n", "d", function()
		require("kulala").download_graphql_schema()
	end, "Download GraphQL schema"),
	keybind("n", "x", function()
		require("kulala").scripts_clear_global()
	end, "Clear global scripts"),
	keybind("n", "i", function()
		require("kulala").inspect()
	end, "Inspect current request"),
	keybind("n", "s", function()
		require("kulala").show_stats()
	end, "Last request stats"),
})
