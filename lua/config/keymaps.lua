-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Small helper that respects lazy-loaded key handlers
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- Do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map({ "n" }, "<leader>v", ":vsp<cr>", { desc = "split window vertically" })
map({ "n" }, "<leader>h", ":sp<cr>", { desc = "split window horizontally" })
map({ "n" }, "¨", "^", { desc = "Start of line (with text)" })

vim.keymap.set("n", "<Tab>", ">>_", { desc = "Indent line", noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<_", { desc = "Unindent line", noremap = true, silent = true })

vim.keymap.set("n", "<C-,>", "<C-f>", { desc = "Page Down", noremap = true, silent = true })
vim.keymap.set("n", "<C-m>", "<C-b>", { desc = "Page Up", noremap = true, silent = true })

map({ "i" }, "<Tab>", "<C-o>>_", { desc = "Indent line", noremap = true, silent = true })
map({ "i" }, "<s-tab>", "<C-o><<_", { desc = "Unindent line", noremap = true, silent = true })

map({ "n" }, "<C-r>", "<cmd>redo<CR>", { desc = "Redo", noremap = true, silent = true })

map({ "n" }, "æ", "<cmd>lua require('which-key').show('[')<CR>", { desc = "[", noremap = true })
map({ "n" }, "ø", "<cmd>lua require('which-key').show(']')<CR>", { desc = "]", noremap = true })

map({ "n" }, "<leader>c1", "<cmd>cc1<CR>", { desc = "Quickfix item 1", noremap = true })
map({ "n" }, "<leader>c2", "<cmd>cc2<CR>", { desc = "Quickfix item 2", noremap = true })
map({ "n" }, "<leader>c3", "<cmd>cc3<CR>", { desc = "Quickfix item 3", noremap = true })
map({ "n" }, "<leader>c4", "<cmd>cc4<CR>", { desc = "Quickfix item 4", noremap = true })
map({ "n" }, "<leader>c5", "<cmd>cc5<CR>", { desc = "Quickfix item 5", noremap = true })
map({ "n" }, "<leader>c6", "<cmd>cc6<CR>", { desc = "Quickfix item 6", noremap = true })
map({ "n" }, "<leader>c7", "<cmd>cc7<CR>", { desc = "Quickfix item 7", noremap = true })
map({ "n" }, "<leader>c8", "<cmd>cc8<CR>", { desc = "Quickfix item 8", noremap = true })
map({ "n" }, "<leader>c9", "<cmd>cc9<CR>", { desc = "Quickfix item 9", noremap = true })

map({ "n" }, "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run request under cursor" })

map({ "n", "v" }, "cp", '"0p', { noremap = true, desc = "Paste from last yank" })
map({ "n", "v" }, "cP", '"0P', { noremap = true, desc = "Insert from last yank" })

vim.keymap.set({ "n", "x", "o" }, ",", "<leader>w", {
  remap = true, -- IMPORTANT: recursive, so it behaves like a prefix
  silent = false,
  desc = "Alias: use <leader>w maps via <leader>z",
})

-----------------------------------------------------------------------
-- Diagnostics: toggle between cursor-line-only ↔ all-lines
-- Works with either virtual_lines (your current setup) or virtual_text.
-- Applies to ALL loaded buffers to override buffer-local settings.
-----------------------------------------------------------------------
-- Diagnostics: toggle between cursor-line-only ↔ all-lines
-----------------------------------------------------------------------
do
  local function toggle_inline_diag_scope()
    local current_vl = vim.diagnostic.config().virtual_lines

    if current_vl == nil or current_vl == false or current_vl == true then
      current_vl = {}
    end

    local current_line = false
    if type(current_vl) == "table" then
      current_line = not current_vl.current_line
    end

    vim.diagnostic.config({ virtual_lines = { current_line = current_line } })

    vim.notify("Inline Diagnostics: " .. (current_line and "current line only" or "all lines"))
  end

  -- Bind directly to override any LazyVim defaults
  vim.keymap.set("n", "<leader>uu", toggle_inline_diag_scope, {
    desc = "Toggle Inline Diagnostics (current line ↔ all lines)",
    silent = true,
  })
end

-----------------------------------------------------------------------
-- Window width: widen (+20) and restore previous width
-----------------------------------------------------------------------
do
  local prev_width = {} ---@type table<integer, integer>

  -- Clean up when a window closes
  vim.api.nvim_create_autocmd("WinClosed", {
    callback = function(args)
      local id = tonumber(args.match)
      if id then
        prev_width[id] = nil
      end
    end,
  })

  local function widen_current(delta)
    local win = vim.api.nvim_get_current_win()
    -- save current width before changing
    prev_width[win] = vim.api.nvim_win_get_width(win)
    vim.cmd(("vertical resize +%d"):format(delta))
    vim.notify(("Widened window by %d cols"):format(delta), vim.log.levels.INFO, { title = "Window" })
  end

  local function restore_current()
    local win = vim.api.nvim_get_current_win()
    local w = prev_width[win]
    if w and w > 0 then
      vim.cmd(("vertical resize %d"):format(w))
      prev_width[win] = nil
      vim.notify("Restored previous window width", vim.log.levels.INFO, { title = "Window" })
    else
      -- Fallback: equalize if we have nothing stored
      vim.cmd("wincmd =")
      vim.notify("No saved width; equalized all windows", vim.log.levels.INFO, { title = "Window" })
    end
  end

  -- <leader>wl → widen current window by 20 columns (saves previous width)
  map("n", "<leader>wl", function()
    widen_current(40)
  end, { desc = "Widen window by 20" })

  -- <leader>wk → restore the saved width (or equalize if none saved)
  map("n", "<leader>wk", restore_current, { desc = "Restore previous window width" })
end

-----------------------------------------------------------------------
-- Swap buffers with neighboring window (keep window sizes)
-----------------------------------------------------------------------
do
  local function swap_with(dir)
    local dirs = { h = "h", j = "j", k = "k", l = "l" }
    local step = dirs[dir]
    if not step then
      return
    end

    local curwin = vim.api.nvim_get_current_win()
    local curbuf = vim.api.nvim_win_get_buf(curwin)

    -- move to neighbor in the requested direction
    vim.cmd("wincmd " .. step)
    local otherwin = vim.api.nvim_get_current_win()
    if otherwin == curwin then
      vim.notify("No window in direction: " .. dir, vim.log.levels.WARN, { title = "Swap buffers" })
      return
    end

    local otherbuf = vim.api.nvim_win_get_buf(otherwin)

    -- swap buffers without touching window sizes
    vim.api.nvim_win_set_buf(curwin, otherbuf)
    vim.api.nvim_win_set_buf(otherwin, curbuf)

    -- restore cursor to original window
    vim.api.nvim_set_current_win(curwin)
  end

  -- Your request: <leader>wx swaps with the window to the RIGHT
  map("n", "<leader>wx", function()
    swap_with("l")
  end, { desc = "Swap buffer with right window" })
end
