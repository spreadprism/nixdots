local path = "~/Projects/Public/rig.nvim"
if require("internal.fs").exists(path) then
	plugin():dir(path):lazy(false):name("rig")
end

plugin("cvigilv/esqueleto.nvim"):event("VeryLazy"):opts({
	directories = { TEMPLATES_PATH },
	wildcards = {
		lookup = {
			["dirname"] = function()
				return vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":t")
			end,
		},
	},
})
