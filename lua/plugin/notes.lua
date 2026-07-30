-- lua/plugin/notes.lua
-- Minimal notes app built on nui.nvim: a 20% sidebar of *.md files in the
-- current directory next to an 80% main pane showing the selected file.
--
-- Keys:  <CR>  open file under cursor   q  close

local M = {}

--- list *.md files in cwd, sorted
---@param cwd string
---@return string[]
function M.list_md_files(cwd)
  local files = {}
  for name in vim.fs.dir(cwd) do
    if name:sub(-3) == ".md" then files[#files + 1] = name end
  end
  table.sort(files)
  return files
end

local state = {} -- { sidebar, main, cwd, files } or {}

local function set_lines(split, lines)
  vim.api.nvim_buf_set_lines(split.bufnr, 0, -1, false, lines)
end

--- open the notes layout for `cwd` (defaults to current working directory)
---@param cwd? string
function M.open(cwd)
  M.close()

  local Split = require("nui.split") -- lazy: keeps the plugin loadable without nui
  cwd = cwd or vim.uv.cwd()
  local files = M.list_md_files(cwd)

  local sidebar = Split({
    relative = "editor",
    position = "left",
    size = "20%",
    enter = true,
    buf_options = { buftype = "nofile", modifiable = true },
    win_options = { winhighlight = "Normal:Normal" },
  })
  local main = Split({
    relative = "editor",
    position = "right",
    size = "80%",
    buf_options = { buftype = "", filetype = "markdown" },
  })
  sidebar:mount()
  main:mount()

  set_lines(sidebar, files)
  vim.bo[sidebar.bufnr].modifiable = false
  set_lines(main, { "# pick a file from the sidebar" })

  -- open the file under the sidebar cursor in the main pane
  vim.keymap.set("n", "<CR>", function()
    local row = vim.api.nvim_win_get_cursor(sidebar.winid)[1]
    local name = files[row]
    if not name then return end
    set_lines(main, vim.fn.readfile(vim.fs.joinpath(cwd, name)))
  end, { buffer = sidebar.bufnr, nowait = true, silent = true })

  -- q closes the whole layout from either pane
  for _, split in ipairs({ sidebar, main }) do
    vim.keymap.set("n", "q", M.close, { buffer = split.bufnr, nowait = true, silent = true })
  end

  state = { sidebar = sidebar, main = main, cwd = cwd, files = files }
end

--- close the notes layout if open
function M.close()
  for _, key in ipairs({ "sidebar", "main" }) do
    if state[key] then
      state[key]:unmount()
      state[key] = nil
    end
  end
  state = {}
end

return M