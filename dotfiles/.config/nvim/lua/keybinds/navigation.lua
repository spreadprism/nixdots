if os.getenv("TMUX") ~= nil then
	keybind("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", "Navigate window left"):register()
	keybind("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", "Navigate window down"):register()
	keybind("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", "Navigate window up"):register()
	keybind("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", "Navigate window right"):register()
else
	keybind("n", "<C-h>", "<CMD>wincmd h<CR>", "Navigate window left"):register()
	keybind("n", "<C-j>", "<CMD>wincmd j<CR>", "Navigate window left"):register()
	keybind("n", "<C-k>", "<CMD>wincmd k<CR>", "Navigate window left"):register()
	keybind("n", "<C-l>", "<CMD>wincmd l<CR>", "Navigate window left"):register()
end
keybind("n", "<C-w>", "<CMD>lua require('nvim-window').pick()<CR>", "Jump to window"):register()
