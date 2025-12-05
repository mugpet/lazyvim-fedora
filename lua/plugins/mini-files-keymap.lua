-- Force <leader>e to mini.files (never Snacks)
return {
  -- 1) Make sure Snacks' Explorer never loads nor maps keys
  {
    "folke/snacks.nvim",
    opts = { explorer = { enabled = false } },
    keys = { { "<leader>e", false } },
  },

  -- 2) Remap <leader>e very late so nothing can override it
  {
    "nvim-mini/mini.files",
    priority = 10000,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          pcall(vim.keymap.del, "n", "<leader>e")
          vim.keymap.set("n", "<leader>e", function()
            local f = vim.api.nvim_buf_get_name(0)
            if f == "" then
              require("mini.files").open(vim.fn.getcwd(), true)
            else
              require("mini.files").open(f, true)
            end
          end, { desc = "Mini Files" })
        end,
      })
    end,
  },
}
