return {
  "folke/tokyonight.nvim",
  opts = {
    transparent = true,
    border = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, _)
      hl.CursorLine = {
        bg = "#1b1e24",
      }
    end,
  },
}
