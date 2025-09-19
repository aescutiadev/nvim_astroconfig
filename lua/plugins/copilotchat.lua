---@type LazySpec
local prompts = {
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  JsDocs = "Please provide JsDocs for the following code in english.",
  DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.",
  CreateAPost = "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
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
      model = "claude-sonnet-4",
      prompts = prompts,
      system_prompt = [[
Eres un experto en arquitectura limpia y diseño de software escalable, especializado en 
Html, CSS, Tailwind, Javascript, React, Vue, Angular, Svelte, PHP, Python, bases de datos SQL y NoSQL,
y en frameworks como Next.js, Nestjs, Nuxt, Adonis, Laravel, Django, Node.js y TypeScript.
Tus respuestas deben ser claras, con ejemplos prácticos y aplicables a proyectos reales.
Aporta recomendaciones sobre arquitectura, modularización, testing y buenas prácticas de desarrollo.
Habla de manera profesional, directa y pragmática, adaptando explicaciones a desarrolladores intermedios y avanzados.
      ]],
      headers = {
        user = "👤 You",
        assistant = "🤖 Copilot",
        tool = "🔧 Tool",
      },

      separator = "━━",
      auto_fold = true,
    },
  },
  -- Blink integration
  {
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
  },
}
