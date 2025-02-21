-- local dadbod = plugin("tpope/vim-dadbod")
-- plugin("kristijanhusak/vim-dadbod-ui"):dependencies(dadbod):cmd({
-- 	"DBUI",
-- 	"DBUIToggle",
-- 	"DBUIAddConnection",
-- 	"DBUIFindBuffer",
-- })
-- -- TODO: add the let g:db_ui_disable_info_notifications = 1
plugin("kndndrj/nvim-dbee")
	:dependencies("MunifTanjim/nui.nvim")
	:build(function()
		require("dbee").install("go")
	end)
	:cmd({
		"Dbee",
	})
	:opts({
		drawer = {
			mappings = {
				{ key = "r", mode = "n", action = "action_2" },
				{ key = "R", mode = "n", action = "refresh" },
				{ key = "<tab>", mode = "n", action = "toggle" },
			},
		},
		editor = {
			mappings = {
				{ key = "<CR>", mode = "v", action = "run_selection" },
				{ key = "<C-e>", mode = "n", action = "run_file" },
			},
		},
	})
