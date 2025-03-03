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
			["cwd"] = function()
				return cwd()
			end,
			["cwd-basename"] = function()
				return vim.fn.fnamemodify(cwd(), ":t")
			end,
			["gh-description"] = function()
				return exec('gh repo view --json description -t "{{ .description }}"')
			end,
		},
	},
})

-- TODO: Add completion source for esqueleto in oil buffers
