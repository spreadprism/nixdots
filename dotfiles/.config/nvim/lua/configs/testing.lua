local function get_nearest_function_name()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local node = ts_utils.get_node_at_cursor()

	while node do
		if node:type() == "function_declaration" then
			return ts_utils.get_node_text(node:child(1))[1]
		end
		node = node:parent()
	end
end

plugin("nvim-neotest/neotest")
	:event("VeryLazy")
	:dependencies({
		-- INFO: core
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- INFO: Adapters
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-python",
		"rouge8/neotest-rust",
		"marilari88/neotest-vitest",
	})
	:config(function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					python = function()
						return require("venv-selector").python()
					end,
				}),
				require("neotest-golang")({}),
				require("neotest-rust"),
				require("neotest-vitest")({
					-- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules"
					end,
				}),
			},
			summary = {
				mappings = {
					expand = { "<tab>" },
					jumpto = "<CR>",
				},
			},
		})
		keybind_group("<leader>u", "Unit testing"):register({
			keybind("n", "e", "<cmd>Neotest summary<cr>", "Tests explorer"),
			keybind("n", "c", "<CMD>lua require('neotest').run.run()<CR>", "Test current function"),
			keybind("n", "c", function()
				local ft = vim.bo.filetype
				if ft == "go" then
					local name = get_nearest_function_name()
					if not name then
						return
					end
					require("neotest").run.run({
						extra_args = { "-run", name },
					})
				else
					require("neotest").run.run()
				end
			end, "Test current function"),
			keybind("n", "f", "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Test current file"),
			keybind("n", "p", "<CMD>lua require('neotest').run.run(vim.fn.getcwd())<CR>", "Test current project"),
		})
	end)
