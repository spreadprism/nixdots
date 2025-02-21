local transparent = plugin("xiyaowong/transparent.nvim")
	:opts({
		extra_groups = { "Notify", "WhichKey", "Telescope" },
		exclude_groups = { "TelescopeSelection", "TelescopePreviewLine" },
	})
	:config(function()
		local transparent = require("transparent")
		transparent.setup({
			exclude_groups = { "TelescopeSelection", "TelescopePreviewLine" },
		})
		transparent.clear_prefix("LspInfoBorder")
		-- transparent.clear_prefix("BlinkCmp")
		transparent.clear_prefix("Telescope")
		transparent.clear_prefix("Notify")
		transparent.clear_prefix("OilVcsStatus")
		transparent.clear_prefix("WhichKey")
		-- transparent.clear_prefix("Pmenu"LspInfoBorderLspInfoBorderLspInfoBorderLspInfoBorderLspInfoBorderLspInfoBorderLspInfoBorderLspInfoBorderLspInfoBorder)
		transparent.clear_prefix("Float")
		transparent.clear_prefix("NormalFloat")
	end)

plugin("zaldih/themery.nvim")
	:lazy(false)
	:priority(1000)
	:dependencies({
		transparent,
		plugin("folke/tokyonight.nvim"):config(function()
			require("tokyonight").setup({ style = "storm" })
		end),
		plugin("baliestri/aura-theme"):config(function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		end),
		plugin("EdenEast/nightfox.nvim"),
	})
	:opts({ themes = { "tokyonight-storm", "aura-dark", "duskfox" } })
