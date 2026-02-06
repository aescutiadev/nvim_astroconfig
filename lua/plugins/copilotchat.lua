-- Configuration for CopilotChat.nvim desabilitated

---@type LazySpec
local prompts = {
  Concise = "Please rewrite the following text to make it more concise.",
  CreateAPost = "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.",
  Documentation = "Please provide documentation for the following code.",
  DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.",
  Explain = "Please explain how the following code works.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  ImproveNamings = "Please provide better names for the following variables and functions.",
  JsDocs = "Please provide JsDocs for the following code in english.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Summarize = "Please summarize the following text.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Wording = "Please improve the grammar and wording of the following text.",
}

local copilot = {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "^4",
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatClose",
    "CopilotChatToggle",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatSave",
    "CopilotChatLoad",
    "CopilotChatModels",
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatFix",
    "CopilotChatOptimize",
    "CopilotChatDocs",
    "CopilotChatTests",
    "CopilotChatCommit",
  },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = opts.options.g.copilot_chat_prefix or "<Leader>a"
        local astroui = require "astroui"

        maps.n[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }
        maps.v[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }

        maps.n[prefix .. "o"] = { ":CopilotChatOpen<CR>", desc = "Open Chat" }
        maps.n[prefix .. "c"] = { ":CopilotChatClose<CR>", desc = "Close Chat" }
        maps.n[prefix .. "t"] = { ":CopilotChatToggle<CR>", desc = "Toggle Chat" }
        maps.n[prefix .. "r"] = { ":CopilotChatReset<CR>", desc = "Reset Chat" }
        maps.n[prefix .. "s"] = { ":CopilotChatStop<CR>", desc = "Stop Chat" }

        maps.n[prefix .. "S"] = {
          function()
            vim.ui.input({ prompt = "Save Chat: " }, function(input)
              if input ~= nil and input ~= "" then require("CopilotChat").save(input) end
            end)
          end,
          desc = "Save Chat",
        }

        maps.n[prefix .. "L"] = {
          function()
            local copilot_chat = require "CopilotChat"
            local path = copilot_chat.config.history_path
            local chats = require("plenary.scandir").scan_dir(path, { depth = 1, hidden = true })
            for i, chat in ipairs(chats) do
              chats[i] = chat:sub(#path + 2, -6)
            end
            vim.ui.select(chats, { prompt = "Load Chat: " }, function(selected)
              if selected ~= nil and selected ~= "" then copilot_chat.load(selected) end
            end)
          end,
          desc = "Load Chat",
        }

        local function select_action(selection_type)
          return function()
            require("CopilotChat").select_prompt { selection = require("CopilotChat.select")[selection_type] }
          end
        end

        maps.n[prefix .. "p"] = {
          select_action "buffer",
          desc = "Prompt actions",
        }
        maps.v[prefix .. "p"] = {
          select_action "visual",
          desc = "Prompt actions",
        }

        local function quick_chat(selection_type)
          return function()
            vim.ui.input({ prompt = "Quick Chat: " }, function(input)
              if input ~= nil and input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select")[selection_type] })
              end
            end)
          end
        end

        maps.n[prefix .. "q"] = { quick_chat "buffer", desc = "Quick Chat" }
        maps.v[prefix .. "q"] = { quick_chat "visual", desc = "Quick Chat" }
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { CopilotChat = "" } } },
  },
  opts = {
    model = "claude-sonnet-4.5",
    prompts = prompts,
    system_prompt = [[
You are an expert in clean architecture and scalable software design, specialized in 
HTML, CSS, Tailwind, Javascript, React, Vue, Angular, Svelte, PHP, Python, SQL and NoSQL databases,
and frameworks like Next.js, Nestjs, Nuxt, Adonis, Laravel, Django, Node.js and TypeScript.
Your responses should be clear, with practical examples applicable to real projects.
Provide recommendations on architecture, modularization, testing and development best practices.
Speak in a professional, direct and pragmatic manner, adapting explanations to intermediate and advanced developers
and all comments in code in english.
      ]],
    headers = {
      user = "👤 You",
      assistant = "🤖 Copilot",
      tool = "🔧 Tool",
    },

    separator = "━━",
    auto_fold = true,
  },
}

-- Blink integration
local blink_copilot = {
  "saghen/blink.cmp",
  optional = true,
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      providers = {
        path = {
          -- Path sources triggered by "/" interfere with CopilotChat commands
          enabled = function() return vim.bo.filetype ~= "copilot-chat" end,
        },
      },
    },
  },
}

local prefix = "<Leader>A"

local codecompanion = {
  "olimorris/codecompanion.nvim",
  event = "User AstroFile",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  specs = {
    {
      "rebelot/heirline.nvim",
      optional = true,

      opts = function(_, opts)
        opts.statusline = opts.statusline or {}
        local spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        local astroui = require "astroui.status.hl"
        table.insert(opts.statusline, {
          static = {
            n_requests = 0,
            spinner_index = 0,
            spinner_symbols = spinner_symbols,
            done_symbol = "✓",
          },
          init = function(self)
            if self._cc_autocmds then return end
            self._cc_autocmds = true
            vim.api.nvim_create_autocmd("User", {
              pattern = "CodeCompanionRequestStarted",
              callback = function()
                self.n_requests = self.n_requests + 1
                vim.cmd "redrawstatus"
              end,
            })
            vim.api.nvim_create_autocmd("User", {
              pattern = "CodeCompanionRequestFinished",
              callback = function()
                self.n_requests = math.max(0, self.n_requests - 1)
                vim.cmd "redrawstatus"
              end,
            })
          end,
          provider = function(self)
            if not package.loaded["codecompanion"] then return nil end
            local symbol
            if self.n_requests > 0 then
              self.spinner_index = (self.spinner_index % #self.spinner_symbols) + 1
              symbol = self.spinner_symbols[self.spinner_index]
            else
              symbol = self.done_symbol
              self.spinner_index = 0
            end
            return ("%d %s"):format(self.n_requests, symbol)
          end,
          hl = function() return astroui.filetype_color() end,
        })
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { CodeCompanion = "󱙺" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        if not opts.mappings then opts.mappings = {} end
        opts.mappings.n = opts.mappings.n or {}
        opts.mappings.v = opts.mappings.v or {}
        opts.mappings.n[prefix] = { desc = require("astroui").get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }
        opts.mappings.v[prefix] = { desc = require("astroui").get_icon("CodeCompanion", 1, true) .. "CodeCompanion" }
        opts.mappings.n[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }
        opts.mappings.v[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }
        opts.mappings.n[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }
        opts.mappings.v[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }
        opts.mappings.n[prefix .. "q"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }
        opts.mappings.v[prefix .. "q"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }
        opts.mappings.v[prefix .. "a"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection to chat" }
      end,
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.file_types = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
      end,
    },
    {
      "OXY2DEV/markview.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.preview then opts.preview = {} end
        if not opts.preview.filetypes then opts.preview.filetypes = { "markdown", "quarto", "rmd" } end
        opts.preview.filetypes = require("astrocore").list_insert_unique(opts.preview.filetypes, { "codecompanion" })
      end,
    },
  },
}

return {
  codecompanion,
}
