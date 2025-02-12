lsp("ast_grep", "ast-grep")
	:display(nil)
	:cmd({
		"sg",
		"lsp",
		"--config",
		vim.fs.joinpath(LUA_DIRECTORY_PATH, "rules", "sgconfig.yml"),
	})
	:root_dir(function()
		return vim.fn.getcwd()
	end)
