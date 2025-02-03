-- jsonnet-language-server jsonnet_ls
lsp("jsonnet_ls", "jsonnet-language-server")
formatter("jsonnet", "jsonnetfmt"):format_opts(function()
	return {
		exe = "jsonnetfmt",
		args = { "-i" },
	}
end)
