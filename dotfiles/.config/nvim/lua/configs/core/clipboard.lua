plugin("ojroques/nvim-osc52")
	:cond(os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil)
	:opts({
		tmux_passthrough = true,
		silent = true,
		trim = true,
	})
	:init(function()
		local copy = function()
			if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
				require("osc52").copy_register("+")
			end
		end

		vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
	end)
