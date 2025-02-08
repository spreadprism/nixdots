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
			vim.cmd("mkview!")
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

plugin("kevinhwang91/nvim-ufo"):dependencies("kevinhwang91/promise-async"):lazy(false):config(function()
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.o.foldcolumn = "0"
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	require("ufo").setup({
		open_fold_hl_timeout = 150,
		fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" 󰁂 %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end,
	})
end)

-- plugin("luukvbaal/statuscol.nvim")
-- 	:config(function()
-- 		local builtin = require("statuscol.builtin")
-- 		require("statuscol").setup({
-- 			setopt = true,
-- 			-- override the default list of segments with:
-- 			-- number-less fold indicator, then signs, then line number & separator
-- 			segments = {
-- 				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
-- 				{ text = { "%s" }, click = "v:lua.ScSa" },
-- 				{
-- 					text = { builtin.lnumfunc, " " },
-- 					condition = { true, builtin.not_empty },
-- 					click = "v:lua.ScLa",
-- 				},
-- 			},
-- 		})
-- 	end)
-- 	:event("VeryLazy")
