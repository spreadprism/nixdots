local dadbod = plugin("tpope/vim-dadbod")
plugin("kristijanhusak/vim-dadbod-ui"):dependencies(dadbod):cmd({
	"DBUI",
	"DBUIToggle",
	"DBUIAddConnection",
	"DBUIFindBuffer",
})
-- TODO: add the let g:db_ui_disable_info_notifications = 1
-- plugin("kndndrj/nvim-dbee")
-- 	:dependencies("MunifTanjim/nui.nvim")
-- 	:build(function()
-- 		require("dbee").install()
-- 	end)
-- 	:config(function()
-- 		require("dbee").setup()
-- 	end)
-- 	:event("VeryLazy")
