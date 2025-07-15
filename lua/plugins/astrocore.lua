-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    icons_enabled = false,
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
        textwidth = 120,
        scrolloff = 8,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["<Leader><space>"] = {
          function()
            require("neo-tree.command").execute {
              toggle = true,
              position = "float",
              source = "filesystem",
              reveal = true,
            }
          end,
          desc = "Open Float Neotree",
        },

        ["<Leader>e"] = {
          function()
            require("neo-tree.command").execute {
              toggle = true,
              position = "left",
              source = "filesystem",
              reveal = true,
            }
          end,
          desc = "Toogle Neotree",
        },

        [","] = {
          "<cmd>lua Snacks.picker.files({exclude = {'.git', 'node_modules', 'dist', 'build', '.cache', 'package-lock.json','vendor', '__pycache__', '.DS_Store'}})<CR>",
          desc = "Find files",
        },

        ["<Leader>ff"] = {
          "<cmd>lua Snacks.picker.files({exclude = {'.git', 'node_modules', 'dist', 'build', '.cache', 'package-lock.json','vendor', '__pycache__', '.DS_Store'}})<CR>",
          desc = "Find files",
        },

        ["<Leader>fw"] = {
          "<cmd>lua Snacks.picker.grep({exclude = {'.git', 'node_modules', 'dist', 'build', '.cache', 'package-lock.json', 'vendor', '__pycache__', '.DS_Store'}})<CR>",
          desc = "Find files",
        },

        ["<Leader>ba"] = {
          function()
            require("neo-tree.command").execute {
              toggle = true,
              position = "float",
              source = "buffers",
              reveal = true,
            }
          end,
          desc = "Open Float Neotree",
        },

        ["<Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        ["q"] = {
          function()
            local answer = vim.fn.input "Start macro recording? (y/n): "
            if answer:lower() == "y" then
              return "q"
            else
              return ""
            end
          end,
          desc = "Prompt before starting macro recording",
        },

        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            require("astrocore.buffer").close(0)
            if not bufs[2] then require("snacks").dashboard() end
          end,
          desc = "Close buffer",
        },

        ["<Leader>ga"] = {
          "<cmd>Gitsigns blame<CR>",
          desc = "Load Git blame in current buffer",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
