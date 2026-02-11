local mpchumb = {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  event = "User AstroFile",
  cmd = "MCPHub",
  opts = {
    log_level = vim.log.levels.DEBUG,
  },
  specs = {},
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      extensions = {
        copilotchat = {
          enabled = true,
          convert_tools_to_functions = true,
          convert_resources_to_functions = true,
          add_mcp_prefix = false,
        },
      },
    },
  },
}

return {
  mpchumb,
}
