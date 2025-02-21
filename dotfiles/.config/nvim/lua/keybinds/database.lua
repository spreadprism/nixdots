local opened = false
local function isInsideDbee()
	-- TODO: do actual detection logic
	local ans = opened
	opened = not opened
	return ans
end

keybind_group("<leader>b", "Database"):register({
	keybind("n", "b", function()
		if isInsideDbee() then
			vim.cmd("Dbee close")
			vim.cmd("bd")
		else
			vim.cmd("tabnew")
			vim.cmd("Dbee open")
		end
	end, "Open DB tab"),
})
