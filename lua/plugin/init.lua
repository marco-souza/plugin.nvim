local cmd = require("cmd")

local M = {}

M.config = {}
M.command = "Plugin"

local subcommands = {
  hello = {
    impl = function(_, _)
      vim.notify("hello from plugin.nvim!")
    end,
  },
}

---@param opts? table user configuration
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  cmd.register(M.command, "Plugin commands", subcommands)
end

return M