plugin("ojroques/nvim-osc52")
	:cond(os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil)
	:opts({
		tmux_passthrough = true,
		silent = true,
		trim = true,
	})
	:init(function()
		local function copy(lines, _)
			require("osc52").copy(table.concat(lines, "\n"))
		end

		local function paste()
			return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
		end

		vim.g.clipboard = {
			name = "osc52",
			copy = { ["+"] = copy, ["*"] = copy },
			paste = { ["+"] = paste, ["*"] = paste },
		}
	end)
