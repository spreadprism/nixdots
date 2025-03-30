local library = { vim.env.VIMRUNTIME }
if cwd() ~= BASE_CONFIG_PATH then
	table.insert(library, LUA_DIRECTORY_PATH)
end
lsp("lua_ls"):settings({
	Lua = {
		workspace = {
			library = library,
		},
	},
})
formatter("lua", "stylua")
