<h1 align="center">Nvim Plugin Template</h1>
<div>
  <h4 align="center">
    <a href="#create-a-new-plugin-from-this-template">Bootstrap</a> ·
    <a href="#prerequisites">Prerequisites</a> ·
    <a href="#install">Install</a> ·
    <a href="#usage">Usage</a> ·
    <a href="#development">Development</a>
  </h4>
</div>
<div align="center">
  <a href="https://github.com/marco-souza/plugin.nvim/releases/latest"
    ><img
      alt="Latest release"
      src="https://img.shields.io/github/v/release/marco-souza/plugin.nvim?style=for-the-badge&logo=starship&logoColor=D9E0EE&labelColor=302D41&&color=d9b3ff&include_prerelease&sort=semver"
  /></a>
  <a href="https://github.com/marco-souza/plugin.nvim/pulse"
    ><img
      alt="Last commit"
      src="https://img.shields.io/github/last-commit/marco-souza/plugin.nvim?style=for-the-badge&logo=github&logoColor=D9E0EE&labelColor=302D41&color=9fdf9f"
  /></a>
  <a href="https://github.com/neovim/neovim/releases/latest"
    ><img
      alt="Latest Neovim"
      src="https://img.shields.io/github/v/release/neovim/neovim?style=for-the-badge&logo=neovim&logoColor=D9E0EE&label=Neovim&labelColor=302D41&color=99d6ff&sort=semver"
  /></a>
  <a href="http://www.lua.org/"
    ><img
      alt="Made with Lua"
      src="https://img.shields.io/badge/Built%20with%20Lua-grey?style=for-the-badge&logo=lua&logoColor=D9E0EE&label=Lua&labelColor=302D41&color=b3b3ff"
  /></a>
</div>
<hr />

Neovim Plugin template (`plugin.nvim`) is a template repository for bootstrapping a neovim plugin.

## Create a new plugin from this template

```sh
# 1. click "Use this template" on GitHub, then clone your new repo
git clone https://github.com/<you>/<your-plugin>.nvim
cd <your-plugin>.nvim

# 2. rename the template to your plugin (lua module, command, README, plugin.json)
make rename NAME=<you>/<your-plugin>.nvim

# 3. verify everything passes
make
```

## Prerequisites

- [Neovim](https://github.com/neovim/neovim/releases) (0.9+)
- [stylua](https://github.com/JohnnyMorganz/StyLua) — formatting
- [luacheck](https://github.com/mpeterv/luacheck) — linting
- `make`, `git`, `perl`

Tests auto-bootstrap [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) on first run, so you don't need to install it manually.

## Install

```lua
-- Lazy plugin spec
{
  "marco-souza/plugin.nvim",
  config = function()
    require("plugin").setup()
  end,
},
```

## Usage

Install it with your plugin manager, then run the `Plugin` user command — it ships with a `hello` subcommand so you can confirm it loaded:

```vim
:Plugin hello
" -> notifies: hello from plugin.nvim!
```

Add a keymap if you like:

```lua
vim.keymap.set("n", "<leader>ph", "<cmd>Plugin hello<cr>")
```

Subcommands are defined in `lua/plugin/init.lua`; add your own there following the table shape in `lua/cmd.lua`.

## Development

```sh
make            # fmt-check + lint + tests (what CI runs)
make tests      # just the specs
make fmt        # reformat lua/
make rename NAME=you/your-plugin.nvim   # point the template at your repo
```

> `plugin.json` holds the version read by the `tag-release` workflow; bump `version` to cut a release.

## License

MIT