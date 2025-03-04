vim.filetype.add({
	extension = {
		tf = "terraform",
		http = "http",
	},
	filename = {
		[".envrc"] = "dotenv",
	},
	pattern = {
		[".env.?.*"] = "dotenv", --> This also matched env_manager.py
	},
})
