local utils = require("internal.dap.utils")

---@class LaunchConfigs
---@field lang string
---@field configs table[]

local LaunchConfigs = {}
LaunchConfigs.__index = LaunchConfigs

---@param lang string
---@param configs table[]
function LaunchConfigs.new(lang, configs)
	local self = setmetatable({}, LaunchConfigs)
	self.lang = lang
	self.configs = configs
	for i, config in ipairs(configs) do
		if not config.type then
			self.configs[i].type = lang
		end
	end
	utils.insert_launch_configs(self)
end

return LaunchConfigs.new
