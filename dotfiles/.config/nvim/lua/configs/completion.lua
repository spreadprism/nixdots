-- plugin("saghen/blink.cmp")
-- 	:event({ "InsertEnter", "CmdlineEnter" })
-- 	:dependencies({
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-cmdline",
-- 		"hrsh7th/cmp-nvim-lua",
-- 		"petertriho/cmp-git",
-- 		"saadparwaiz1/cmp_luasnip",
-- 	})
-- 	:opts({
-- 		appearance = {
-- 			use_nvim_cmp_as_default = true,
-- 		},
-- 		snippets = { "luasnip" },
-- 		keymap = {
-- 			preset = "none",
-- 			["<M-a>"] = { "select_and_accept", "fallback" },
-- 			["<M-j>"] = { "select_next", "fallback" },
-- 			["<M-k>"] = { "select_prev" },
-- 			["<M-x>"] = { "cancel" },
-- 			["<M-l>"] = {
-- 				function(cmp)
-- 					if cmp.visible() then
-- 						cmp.close()
-- 					end
-- 					require("copilot.suggestion").next()
-- 				end,
-- 			},
-- 			["<M-h>"] = {
-- 				function(cmp)
-- 					if cmp.is_visible() then
-- 						cmp.hide()
-- 					else
-- 						cmp.show()
-- 					end
-- 				end,
-- 			},
-- 		},
-- 	})
plugin("hrsh7th/nvim-cmp")
	:event("VeryLazy")
	:dependencies({
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"petertriho/cmp-git",
		"saadparwaiz1/cmp_luasnip",
		-- plugin("kristijanhusak/vim-dadbod-completion"):dependencies("tpope/vim-dadbod"),
		plugin("MattiasMTS/cmp-dbee"):dependencies("kndndrj/nvim-dbee"):ft("sql"),
		plugin("hrsh7th/cmp-nvim-lsp"):dependencies("neovim/nvim-lspconfig"),
	})
	:config(function()
		local cmp = require("cmp")
		local select_opts = { behavior = cmp.SelectBehavior.Select }
		local cmp_kinds = {
			Text = "  ",
			Method = "  ",
			Function = "  ",
			Constructor = "  ",
			Field = "  ",
			Variable = "  ",
			Class = "  ",
			Interface = "  ",
			Module = "  ",
			Property = "  ",
			Unit = "  ",
			Value = "  ",
			Enum = "  ",
			Keyword = "  ",
			Snippet = "  ",
			Color = "  ",
			File = "  ",
			Reference = "  ",
			Folder = "  ",
			EnumMember = "  ",
			Constant = "  ",
			Struct = "  ",
			Event = "  ",
			Operator = "  ",
			TypeParameter = "  ",
			Copilot = "  ",
		}

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			preselect = cmp.PreselectMode.None,
			sources = cmp.config.sources({
				{ name = "luasnip", option = { use_show_condition = false } },
				{ name = "nvim_lsp" },
				{ name = "vim-dadbod-completion" },
				{ name = "nvim_lua" },
				{ name = "git" },
				{ name = "path" },
				{ name = "crates" },
				{ name = "buffer", keyword_length = 5 },
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					if entry.source.name == "path" then
						item.kind = cmp_kinds.Folder
						item.menu = "(path)"
					else
						local kind = cmp_kinds[item.kind] or ""
						if item.kind ~= "Copilot" then
							item.menu = "(" .. item.kind .. ")"
						end
						item.kind = kind
					end
					return item
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
				}),
			},
			mapping = {
				["<M-a>"] = cmp.mapping.confirm({ select = true }),
				["<M-x>"] = cmp.mapping.abort(),
				["<M-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item(select_opts)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<M-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(select_opts)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			experimental = {
				ghost_text = true,
				native_menu = false,
			},
		})
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		cmp.event:on("menu_opened", function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on("menu_closed", function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end)
