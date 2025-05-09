-- reference: https://github.com/nvim-lua/plenary.nvim/blob/master/TESTS_README.md

local replace_envs = require("utils.env").replace_envs

describe("replace strings", function()
  it("with no envs", function()
    local env_str = "no-env-to-replace"
    local output = replace_envs(env_str)

    assert.equals(output, env_str)
  end)

  it("with one env", function()
    local env_str = "hello $PWD"
    local env_value = os.getenv("PWD")
    local output = replace_envs(env_str)

    assert.equals(output, "hello " .. env_value)
  end)

  it("with multiple envs", function()
    local env_str = "hello $PWD, your home is $HOME"
    local env_value_pwd = vim.fn.getenv("PWD")
    local env_value_home = vim.fn.getenv("HOME")

    local expected = "hello "
      .. env_value_pwd
      .. ", your home is "
      .. env_value_home

    local output = replace_envs(env_str)

    assert.equals(output, expected)
  end)
end)
