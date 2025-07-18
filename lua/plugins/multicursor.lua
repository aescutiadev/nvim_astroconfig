return {
  "mg979/vim-visual-multi",
  event = { "User AstroFile", "InsertEnter" },
  dependencies = {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      if not opts.options then opts.options = {} end
      if not opts.options.g then opts.options.g = {} end
      opts.options.g.VM_leader = "," -- Cambia el líder de \\ a , para evitar conflictos
      opts.options.g.VM_silent_exit = 0
      opts.options.g.VM_show_warnings = 1
      opts.options.g.VM_set_statusline = 1

      if not opts.autocmds then opts.autocmds = {} end
      opts.autocmds.visual_multi_exit = {
        {
          event = "User",
          pattern = "visual_multi_exit",
          desc = "Avoid spurious 'hit-enter-prompt' when exiting vim-visual-multi",
          callback = function()
            vim.o.cmdheight = 1
            vim.schedule(function() vim.o.cmdheight = opts.options.opt.cmdheight end)
          end,
        },
      }

      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = assert(opts.mappings)
      maps.n["<A-k>"] = {
        "<C-u>call vm#commands#add_cursor_up(0, v:count1)<cr>",
        desc = "Add cursor above",
      }
      maps.n["<A-j>"] = {
        "<C-u>call vm#commands#add_cursor_down(0, v:count1)<cr>",
        desc = "Add cursor below",
      }
    end,
  },
}
