-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
    },
  },

  "andweeb/presence.nvim",
  -- == Examples of Overriding Plugins ==

  {
    "folke/snacks.nvim",
    opts = {
      animate = { enabled = true },
      dashboard = {
        preset = {
          header = table.concat({
            "                                                                 ",
            "   █████╗ ███████╗███████╗ ██████╗██╗   ██╗████████╗██╗ █████╗   ",
            "  ██╔══██╗██╔════╝██╔════╝██╔════╝██║   ██║╚══██╔══╝██║██╔══██╗  ",
            "  ███████║█████╗  ███████╗██║     ██║   ██║   ██║   ██║███████║  ",
            "  ██╔══██║██╔══╝  ╚════██║██║     ██║   ██║   ██║   ██║██╔══██║  ",
            "  ██║  ██║███████╗███████║╚██████╗╚██████╔╝   ██║   ██║██║  ██║  ",
            "  ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═╝╚═╝  ╚═╝  ",
            "                                                                 ",
            "                     ██████╗ ███████╗██╗   ██╗                   ",
            "                     ██╔══██╗██╔════╝██║   ██║                   ",
            "                     ██║  ██║█████╗  ██║   ██║                   ",
            "                     ██║  ██║██╔══╝  ╚██╗ ██╔╝                   ",
            "                     ██████╔╝███████╗ ╚████╔╝                    ",
            "                     ╚═════╝ ╚══════╝  ╚═══╝                     ",
            "                                                                 ",
          }, "\n"),
        },
      },
      indent = {
        indent = {
          enabled = false,
        },
        scope = {
          enabled = true,
          only_current = true,
          only_scope = true,
          char = "│",
        },
      },
      notifier = {
        enabled = true,
        timeout = 6000,
      },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
  },
}
