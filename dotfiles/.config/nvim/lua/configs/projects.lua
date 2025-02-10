plugin("jedrzejboczar/exrc.nvim"):event("VeryLazy"):config(function()
	require("exrc").setup({
		on_vim_enter = false,
	})
	require("exrc.loader").on_vim_enter()
end)
