local conditions = require "heirline.conditions"

local CustomFileInfo = {
  init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
  {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self) return self.icon and (self.icon .. " ") end,
    hl = function(self) return { fg = self.icon_color } end,
  },
  {
    hl = function()
      if vim.bo.modified then return { fg = "cyan", bold = true, force = true } end
      return { fg = vim.api.nvim_get_hl(0, { name = "Directory" }).fg }
    end,
    provider = function(self)
      local filename = vim.fn.fnamemodify(self.filename, ":.")
      if filename == "" then return "[No Name]" end
      if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end
      return filename
    end,
  },
  {
    condition = function() return vim.bo.modified or not vim.bo.modifiable or vim.bo.readonly end,
    provider = function()
      if vim.bo.modified then
        return " [+]"
      elseif not vim.bo.modifiable or vim.bo.readonly then
        return " "
      end
      return ""
    end,
    hl = { fg = "orange" },
  },
  { provider = "%<" },
}

return {
  "rebelot/heirline.nvim",
  dependencies = {
    { -- configure AstroUI to include a new UI icon
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        icons = {
          Clock = "", -- add icon for clock
        },
      },
    },
  },
  opts = function(_, opts)
    local status = require "astroui.status"
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      {
        CustomFileInfo,
        surround = { separator = "none", color = "file_info_bg" },
        padding = { left = 1, right = 1 },
      },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      -- Create a custom component to display the time
      status.component.builder {
        {
          provider = function()
            local time = os.date "%H:%M" -- show hour and minute in 24 hour format
            ---@cast time string
            return status.utils.stylize(time, {
              icon = { kind = "Clock", padding = { right = 1 } }, -- use our new clock icon
              padding = { right = 1 }, -- pad the right side so it's not cramped
            })
          end,
        },
        update = { -- update should happen when the mode has changed as well as when the time has changed
          "User", -- We can use the User autocmd event space to tell the component when to update
          "ModeChanged",
          callback = vim.schedule_wrap(function(_, args)
            if -- update on user UpdateTime event and mode change
              (args.event == "User" and args.match == "UpdateTime")
              or (args.event == "ModeChanged" and args.match:match ".*:.*")
            then
              vim.cmd.redrawstatus() -- redraw on update
            end
          end),
        },
        hl = { fg = "white", bg = status.hl.mode_bg() },
        surround = { separator = "right", color = status.hl.mode_bg }, -- background highlight based on mode
        padding = { left = 1 }, -- pad the left and right side so it's not cramped
      },
    }

    -- Now that we have the component, we need a timer to emit the User UpdateTime event
    vim.uv.new_timer():start( -- timer for updating the time
      (60 - tonumber(os.date "%S")) * 1000, -- offset timer based on current seconds past the minute
      60000, -- update every 60 seconds
      vim.schedule_wrap(function()
        vim.api.nvim_exec_autocmds( -- emit our new User event
          "User",
          { pattern = "UpdateTime", modeline = false }
        )
      end)
    )
  end,
}
