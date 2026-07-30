-- tests/bootstrap.lua — ensures plenary.nvim is on the rtp, then runs specs.
-- Run everything with: nvim --headless -c "luafile tests/bootstrap.lua"

local plenary_path = vim.fn.stdpath("data") .. "/site/pack/tests/start/plenary.nvim"
if not (vim.uv or vim.loop).fs_stat(plenary_path) then
  plenary_path = os.getenv("PLENARY_PATH") or (vim.fn.getcwd() .. "/.deps/plenary.nvim")
  if not (vim.uv or vim.loop).fs_stat(plenary_path) then
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/nvim-lua/plenary.nvim.git",
      plenary_path,
    })
  end
end
vim.opt.rtp:prepend(plenary_path)

-- make the plugin's lua/ resolvable by require("plugin")
vim.opt.rtp:prepend(vim.fn.getcwd())

require("plenary.busted")