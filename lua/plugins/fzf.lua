return {
  {
    "ibhagwan/fzf-lua",
    -- We use 'config' to absolutely force these settings over any defaults
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        -- 1. WINDOW: Vertical Split (Search Top -> List -> Preview Bottom)
        winopts = {
          height = 0.95,
          width = 0.95,
          preview = {
            layout = "vertical", -- Stacks the preview window below the list
            vertical = "down:65%", -- Preview takes the bottom 50%
            title = true, -- Show titles
            scrollbar = "float", -- Float scrollbar
          },
        },

        -- 2. SEARCH BAR: Force it to the Top
        fzf_opts = {
          ["--layout"] = "reverse", -- "reverse" moves the prompt to the top
          ["--info"] = "inline", -- Show result count inline
        },

        -- 3. KEYBINDINGS (Optional but recommended)
        keymap = {
          builtin = {
            ["<C-d>"] = "preview-page-down",
            ["<C-u>"] = "preview-page-up",
          },
          fzf = {
            ["ctrl-d"] = "preview-page-down",
            ["ctrl-u"] = "preview-page-up",
          },
        },
      })
    end,
  },
}
