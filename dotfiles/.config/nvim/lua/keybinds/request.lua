keybind_group("<leader>r", "requests"):register({
	keybind("n", "r", function()
		require("kulala").run()
	end, "Run the current request"),
	keybind("n", "R", function()
		require("kulala").run_all()
	end, "Run the current request"),
	keybind("n", "l", function()
		require("kulala").replay()
	end, "Run the last request"),
})
