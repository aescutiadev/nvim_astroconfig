return {
  {
    "AstroNvim/astrotheme",
    opts = {
      style = {
        transparent = true, -- enable transparent background
        inactive = false, -- enable inactive window transparency
        border = true, -- enable border transparency
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = true,
      border = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, _)
        hl.CursorLine = {
          bg = "#1a1b26", -- #1c1c1c #0d1117
        }
      end,
      -- style = "night",
    },
  },
}
