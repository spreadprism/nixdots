plugin("jedrzejboczar/exrc.nvim"):event("VeryLazy"):config(function()
	require("exrc").setup({
		on_vim_enter = false,
	})
	require("exrc.loader").on_vim_enter()
end)

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*/.nvim.lua" },
	callback = function()
		vim.defer_fn(function()
			vim.cmd("ExrcReloadAll")
		end, 100)
	end,
})
