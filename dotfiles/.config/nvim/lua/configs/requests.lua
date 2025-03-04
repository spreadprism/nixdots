-- TODO: Add kulala-ls
plugin("mistweaverco/kulala.nvim")
	:opts({
		global_keymaps = false,
		vscode_rest_client_environmentvars = true,
		debug = true,
	})
	:event("VeryLazy")
