keybind("i", "<M-h>", function ()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.close()
  else
    cmp.complete()
  end
end, "copilot next"):register()
