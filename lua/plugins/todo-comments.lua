return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- Add your custom keywords here
    keywords = {
      FIX = {
        icon = " ", -- Icon for the keyword
        color = "error", -- Can be a hex color, or a named color (see highlight groups)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternative keywords that you might use
      },
      TODO = { icon = "🔥", color = "#ff9000" },
      NOTE = { icon = " ", color = "#efe062" },
      INFO = { icon = " ", color = "#40ff50" },
      DONE = { icon = " ", color = "#40e000" },
      IMPORTANT = { icon = " ", color = "#ff7860" },
      WARN = { icon = "⚠", color = "#ff6000", alt = { "HACK" } },
      -- YOUTUBE = { icon = " ", color = "#fe0000" },
      -- Add more custom keywords as needed
    },
    -- Other configuration options...
    --
  },
}

-- YOUTUBE: this should work
-- NOTE: Stille here
-- IMPORTANT: this is important
-- WARNING: yse
-- TODO: do this
-- FIXME: fix this
-- BUG: fix this
-- ISSUE: fix this
-- FIXIT: fix this
-- XXX: fix this
-- HACK: fix this
-- WARN: fix this
-- PERF: fix this
-- NOTE: fix this
-- REVIEW: fix this
-- NB: fix this
-- BUG: fix this
-- QUESTION: fix this
-- DONE: fix this
-- INFO: fix this
-- IDEA: fix this
--
