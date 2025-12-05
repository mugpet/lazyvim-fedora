-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autocommand to open fzf
-- -Kill the default empty buffer
-- cd into that directory
-- Launch your FZF file picker (it auto‑detects whether you’re using fzf-lua or fzf.vim)-
-- ~/.config/nvim/lua/autocmds.lua
-- Autocommand to open fzf-lua when starting Neovim with a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local target = vim.fn.argv(0)
    -- Check if the first argument is a directory
    if target and vim.fn.isdirectory(target) == 1 then
      -- Delete the empty buffer that Neovim opens by default
      local bufnr = vim.api.nvim_get_current_buf()
      if
        vim.bo[bufnr].buftype == ""
        and vim.fn.getbufinfo(bufnr)[1].linecount == 1
        and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == ""
      then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end

      -- Change current working directory to the target
      vim.cmd("cd " .. vim.fn.fnameescape(target))

      -- Use vim.cmd to correctly trigger the lazy-loaded plugin
      vim.cmd("FzfLua files")
    end
  end,
  desc = "Open fzf-lua on startup in a directory",
})
