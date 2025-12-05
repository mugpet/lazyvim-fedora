-- return {
--   "https://github.com/craftzdog/solarized-osaka.nvim",
--   lazy = false,
--   priority = 1000,
--   opt = function ()
--     return {
--      transparent = true
--     }
--   end
-- }
-- return { "catppuccin/nvim", lazy=false, name = "catppuccin", priority = 1000 }

return {
  -- { "AlexvZyl/nordic.nvim", lazy = false, priority = 1000 },
  -- { "polirritmico/monokai-nightasty.nvim", lazy = false, priority = 1000 },
  -- { "neanias/everforest-nvim", lazy = false, priority = 1000 },
  -- { "sainnhe/sonokai", lazy = false, priority = 1000 },
  --
  -- { "Abstract-IDE/Abstract-cs", lazy = false, priority = 1000 },

  { "mugpet/degrande-dracula.nvim", lazy = false, priority = 1000 },

  -- {
  --     "c:/code/themes/degrande-dracula.nvim",
  --     requires = { "c:/code/themes/degrande-dracula.nvim" },
  --     dir = "c:/code/themes/degrande-dracula.nvim",
  --     as = "degrande dracula",
  --     lazy = false,
  --     priority = 1000,
  -- },

  -- {
  --   "/mnt/c/code/themes/degrande-dracula.nvim",
  --   requires = { "/mnt/c/code/themes/degrande-dracula.nvim" },
  --   dir = "/mnt/c/code/themes/degrande-dracula.nvim",
  --   as = "degrande dracula",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- { "bluz71/vim-moonfly-colors", lazy = false, priority = 1000 },
  -- { "olivercederborg/poimandres.nvim", lazy = false, priority = 1000 },
  -- { "felipeagc/fleet-theme-nvim", lazy = false, priority = 1000 },
  -- { "zootedb0t/citruszest.nvim", lazy = false, priority = 1000 },
  -- { "Domeee/mosel.nvim", lazy = false, priority = 1000 },
  -- { "projekt0n/github-nvim-theme", lazy = false, priority = 1000 },
  --
  -- { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
  -- { "catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000 },
  -- { "tiagovla/tokyodark.nvim", lazy = false, name = "tokyodark", priority = 1000 },
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = true,
  --   name = "onedark",
  --   opts = function() end,
  --   config = function()
  --     require("onedark").setup({
  --       style = "warmer",
  --       -- style = "deep",
  --     })
  --   end,
  --   priority = 1000,
  -- },
  --
  -- -- { "https://github.com/mhartington/oceanic-next", lazy = false, priority = 1000 },
  -- -- { "https://github.com/sainnhe/edge", lazy = false, priority = 1000 },
  -- -- { "https://github.com/Th3Whit3Wolf/one-nvim", lazy = false, priority = 1000 },
  -- -- { "https://github.com/yonlu/omni.vim", lazy = false, priority = 1000 },
  -- { "https://github.com/shaunsingh/moonlight.nvim", lazy = false, priority = 1000 },
  -- -- { "https://github.com/navarasu/onedark.nvim", lazy = false, priority = 1000 },
  -- { "https://github.com/Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
  -- import any extras modules here
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
  -- { import = "lazyvim.plugins.extras.ui.mini-animate" },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      colorscheme = "dracula-vine",
    },
  },
}
