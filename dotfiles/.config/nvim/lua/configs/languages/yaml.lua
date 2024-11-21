lsp("yamlls", "yaml-language-server"):on_attach(function(client, bufnr)
	local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
	if ft == "helm" then
		client.stop()
	end
end)

formatter("yaml", "prettier")
