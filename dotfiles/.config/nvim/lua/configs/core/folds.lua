-- Add UFO plugin

local ft = {
	"go",
}
vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = "remember_folds",
	pattern = "*",
	callback = function()
		if vim.tbl_contains(ft, vim.bo.filetype) then
			vim.cmd("mkview")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "remember_folds",
	pattern = "*",
	callback = function()
		if vim.tbl_contains(ft, vim.bo.filetype) then
			vim.cmd("silent! loadview")
		end
	end,
})
