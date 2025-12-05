-- lua/plugins/bufferline.lua
return {
  -- Use mini.bufremove for reliable buffer closing
  {
    "nvim-mini/mini.bufremove",
    version = "*",
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",

    -- ✅ Keys: jump to *visible* slot 1..9 (fixes the mismatch with long tablines)
    keys = (function()
      local maps = {
        { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
        { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
        {
          "<leader>bd",
          function() require("mini.bufremove").delete(0, false) end,
          desc = "Delete buffer",
        },
        {
          "<leader>bD",
          function() require("mini.bufremove").delete(0, true) end,
          desc = "Delete buffer (force)",
        },
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Pin/Unpin buffer" },
      }
      for i = 1, 9 do
        table.insert(maps, {
          ("<leader>%d"):format(i),
          function() require("bufferline").go_to(i, true) end, -- true = use visible index
          desc = ("Go to visible tab %d"):format(i),
        })
      end
      return maps
    end)(),

    opts = {
      options = {
        mode = "buffers",
        numbers = "ordinal",           -- show 1..9 on the tabs themselves
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _)
          local icon = (level == "error" or level == "e") and " " or " "
          return " " .. icon .. count
        end,

        always_show_bufferline = true,
        enforce_regular_tabs = true,   -- predictable widths help when crowded
        max_name_length = 18,
        max_prefix_length = 12,
        tab_size = 18,
        truncate_names = true,         -- keep more tabs visible

        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",

        -- Keep file explorers from shrinking the line weirdly
        offsets = {
          { filetype = "neo-tree", text = "Neo-tree", highlight = "Directory", text_align = "left" },
          -- { filetype = "oil", text = "Oil", highlight = "Directory", text_align = "left" }, -- if you switch explorer
        },

        -- Optional: group pinned buffers first (nice when you pin a few and open many)
        sort_by = function(a, b)
          if a.group and b.group and a.group ~= b.group then return a.group < b.group end
          if a.ordinal and b.ordinal then return a.ordinal < b.ordinal end
        end,
      },
      highlights = {
        -- Make the selected tab pop a bit but keep things compact
        buffer_selected = { italic = false, bold = true },
      },
    },

    config = function(_, opts)
      require("bufferline").setup(opts)

      -- Optional: when closing a buffer, keep window layout stable
      vim.keymap.set("n", "<leader>bc", function()
        require("mini.bufremove").delete(0, false)
      end, { desc = "Close buffer (keep layout)" })
    end,
  },
}
