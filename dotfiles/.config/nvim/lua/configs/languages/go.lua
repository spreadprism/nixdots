lsp("gopls"):settings({
	directoryFilters = {
		"-/nix/**",
	},
})
dap("delve"):initialize(false)
formatter("go", "gofmt"):install(false)
linter("go", "golangcilint", "golangci-lint")
-- launch_configs("go", {
-- 	{
-- 		name = "Launch current file",
-- 		type = "go",
-- 		request = "launch",
-- 		program = "${file}",
-- 	},
-- })

plugin("leoluz/nvim-dap-go")
	:ft("go")
	:dependencies({ "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" })
	:config(function()
		require("dap-go"):setup({
			-- delve = {
			-- 	path = require("mason-registry").get_package("delve"):get_install_path(),
			-- },
			-- experimental = {
			-- 	test_table = true,
			-- },
		})
		require("internal.dap").refresh_configurations("go") -- INFO: Removes the default configs
	end)
