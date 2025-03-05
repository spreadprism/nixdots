-- TODO: Add kulala-ls
plugin("spreadprism/kulala.nvim")
	:opts({
		global_keymaps = false,
		vscode_rest_client_environmentvars = true,
		-- debug = true,
	})
	:event("VeryLazy")
