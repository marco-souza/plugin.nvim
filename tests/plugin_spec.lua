local plugin = require("plugin")

describe("plugin", function()
  it("setup() merges options into config", function()
    plugin.setup({ foo = "bar" })
    assert.equals("bar", plugin.config.foo)
  end)

  it("registers its user command", function()
    plugin.setup({})
    local cmds = vim.api.nvim_get_commands({})
    assert.is_truthy(cmds[plugin.command])
  end)
end)