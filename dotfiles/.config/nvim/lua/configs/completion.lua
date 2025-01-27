-- plugin("Saghen/blink.cmp")
-- 	:dependencies({
-- 		"Saghen/blink.compat",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-cmdline",
-- 		"hrsh7th/cmp-nvim-lua",
-- 		"petertriho/cmp-git",
-- 	})
-- 	:build("nix run .#build-plugin")
-- 	:opts({
-- 		snippets = { preset = "luasnip" },
-- 		sources = {
-- 			default = {
-- 				"lsp",
-- 				"snippets",
-- 				"git",
-- 				"path",
-- 				"buffer",
-- 				-- "nvim_lua",
-- 				-- "vim-dadbod-completion",
-- 			},
-- 			providers = {
-- 				git = {
-- 					name = "git",
-- 					module = "blink.compat.source",
-- 				},
-- 				path = {
-- 					name = "path",
-- 					module = "blink.compat.source",
-- 				},
-- 				buffer = {
-- 					name = "buffer",
-- 					module = "blink.compat.source",
-- 					opts = {
-- 						keyword_length = 5,
-- 					},
-- 				},
-- 			},
-- 			-- 				{ name = "nvim_lsp" },
-- 			-- 				{ name = "luasnip", option = { use_show_condition = false } },
-- 			-- 				{ name = "vim-dadbod-completion" },
-- 			-- 				{ name = "nvim_lua" },
-- 			-- 				{ name = "git" },
-- 			-- 				{ name = "path" },
-- 			-- 				{ name = "crates" },
-- 			-- 				{ name = "buffer", keyword_length = 5 },
-- 		},
-- 		keymap = {
-- 			preset = "none",
-- 			["<M-j>"] = { "select_next" },
-- 			["<M-k>"] = { "select_prev" },
-- 			["<M-a>"] = { "select_and_accept" },
-- 			["<M-x>"] = { "cancel" },
-- 		},
-- 		completion = {
-- 			ghost_text = { enabled = true },
-- 		},
-- 	})
-- 	:event("VeryLazy")

plugin("hrsh7th/nvim-cmp")
	:event("VeryLazy")
	:dependencies({
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"petertriho/cmp-git",
		-- "MattiasMTS/cmp-dbee",
		"saadparwaiz1/cmp_luasnip",
		plugin("kristijanhusak/vim-dadbod-completion"):dependencies("tpope/vim-dadbod"),
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
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip", option = { use_show_condition = false } },
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
