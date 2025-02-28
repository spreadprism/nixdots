local treesitter_textobject = plugin("nvim-treesitter/nvim-treesitter-textobjects"):event("VeryLazy"):enabled(true) -- TODO: Config textobjects
local treesitter = plugin("nvim-treesitter/nvim-treesitter")
	:event("BufRead")
	:dependencies(treesitter_textobject)
	:config(function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = false, -- INFO: taken care of by mini.ai
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "Next function" },
						["]c"] = { query = "@class.outer", desc = "Next class" },
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
					},
				},
			},
			endwise = {
				enable = true,
			},
			ensure_installed = require("internal.treesitter").ensure_installed(),
		})
		vim.treesitter.language.register("bash", "dotenv")
		vim.treesitter.language.register("python", "bzl")
	end)
plugin("windwp/nvim-ts-autotag"):event({ "BufReadPre", "BufNewFile" }):opts({})
-- plugin("altermo/ultimate-autopair.nvim"):event({ "InsertEnter", "CmdlineEnter" }):opts({})
plugin("echasnovski/mini.pairs"):event({ "InsertEnter", "CmdlineEnter" }):opts({
	-- In which modes mappings from this `config` should be created
	modes = { insert = true, command = true, terminal = false },

	-- Global mappings. Each right hand side should be a pair information, a
	-- table with at least these fields (see more in |MiniPairs.map|):
	-- - <action> - one of 'open', 'close', 'closeopen'.
	-- - <pair> - two character string for pair to be used.
	-- By default pair is not inserted after `\`, quotes are not recognized by
	-- `<CR>`, `'` does not insert pair after a letter.
	-- Only parts of tables can be tweaked (others will use these defaults).
	mappings = {
		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
		["["] = {
			action = "open",
			pair = "[]",
			neigh_pattern = ".[%s%z%)}%]%,]",
			register = { cr = false },
			-- foo|bar -> press "[" -> foo[bar
			-- foobar| -> press "[" -> foobar[]
			-- |foobar -> press "[" -> [foobar
			-- | foobar -> press "[" -> [] foobar
			-- foobar | -> press "[" -> foobar []
			-- {|} -> press "[" -> {[]}
			-- (|) -> press "[" -> ([])
			-- [|] -> press "[" -> [[]]
		},
		["{"] = {
			action = "open",
			pair = "{}",
			-- neigh_pattern = ".[%s%z%)}]",
			neigh_pattern = ".[%s%z%)}%]%,]",
			register = { cr = false },
			-- foo|bar -> press "{" -> foo{bar
			-- foobar| -> press "{" -> foobar{}
			-- |foobar -> press "{" -> {foobar
			-- | foobar -> press "{" -> {} foobar
			-- foobar | -> press "{" -> foobar {}
			-- (|) -> press "{" -> ({})
			-- {|} -> press "{" -> {{}}
		},
		["("] = {
			action = "open",
			pair = "()",
			-- neigh_pattern = ".[%s%z]",
			neigh_pattern = ".[%s%z%)%,]",
			register = { cr = false },
			-- foo|bar -> press "(" -> foo(bar
			-- foobar| -> press "(" -> foobar()
			-- |foobar -> press "(" -> (foobar
			-- | foobar -> press "(" -> () foobar
			-- foobar | -> press "(" -> foobar ()
		},
		-- Single quote: Prevent pairing if either side is a letter
		['"'] = {
			action = "closeopen",
			pair = '""',
			neigh_pattern = "[^%w\\][^%w]",
			register = { cr = false },
		},
		-- Single quote: Prevent pairing if either side is a letter
		["'"] = {
			action = "closeopen",
			pair = "''",
			neigh_pattern = "[^%w\\][^%w]",
			register = { cr = false },
		},
		-- Backtick: Prevent pairing if either side is a letter
		["`"] = {
			action = "closeopen",
			pair = "``",
			neigh_pattern = "[^%w\\][^%w]",
			register = { cr = false },
		},
	},
})
plugin("RRethy/nvim-treesitter-endwise"):dependencies(treesitter):event("VeryLazy")
plugin("kylechui/nvim-surround"):event("VeryLazy"):opts({})
plugin("abecodes/tabout.nvim"):dependencies({ "hrsh7th/nvim-cmp", treesitter }):event("InsertCharPre"):opts({
	act_as_shift_tab = true,
	tabouts = {
		{ open = "'", close = "'" },
		{ open = '"', close = '"' },
		{ open = "`", close = "`" },
		{ open = "(", close = ")" },
		{ open = "[", close = "]" },
		{ open = "{", close = "}" },
	},
}) -- TODO: Fix the plugin, its flaky
plugin("echasnovski/mini.surround"):event("VeryLazy"):opts({
	mappings = {
		delete = "",
		find = "",
		find_left = "",
		highlight = "",
		replace = "",
		update_n_lines = "",
		suffix_last = "",
		suffix_next = "",
	},
})
plugin("echasnovski/mini.ai"):event("VeryLazy"):config(function()
	local gen_spec = require("mini.ai").gen_spec
	require("mini.ai").setup({
		custom_textobjects = {
			f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			i = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
			g = gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
			l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
			p = gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
			r = gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }),
		},
	})
end)
plugin("echasnovski/mini.move"):event("VeryLazy"):opts({
	mappings = {
		up = "<M-k>",
		down = "<M-j>",
		right = "",
		left = "",
		line_left = "",
		line_right = "",
		line_down = "<M-j>",
		line_up = "<M-k>",
	},
})
plugin("numToStr/Comment.nvim"):event("VeryLazy"):opts({})
plugin("roobert/search-replace.nvim"):event("VeryLazy"):opts({})
plugin("echasnovski/mini.diff"):event("VeryLazy"):opts({})
