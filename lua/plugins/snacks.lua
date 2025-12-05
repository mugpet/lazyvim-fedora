return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      -- Set the default layout to "vertical"
      layout = {
        preset = "vertical",
        layout = {
          width = 0.95, -- Width: 95% of screen
          height = 0.95, -- Height: 95% of screen

          backdrop = false,
          min_width = 80,
          min_height = 30,
          box = "vertical",
          border = true,
          title = "{title} {live} {flags}",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
          { win = "preview", title = "{preview}", height = 0.7, border = "top" },
        },
      },

      -- Optional: visual tweaks to match your previous setup
      win = {
        input = {
          keys = {
            -- If you want to close on Esc in Normal mode
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
  },
}
