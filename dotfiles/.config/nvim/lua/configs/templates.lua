local path = "~/Projects/Public/rig.nvim"
if require("internal.fs").exists(path) then
	plugin():dir(path):lazy(false):name("rig")
end
