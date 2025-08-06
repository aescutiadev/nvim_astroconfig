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
    icons_enabled = true,
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
        -- Line numbers and display
        relativenumber = true, -- Show line numbers relative to cursor position
        number = true, -- Show absolute line numbers
        signcolumn = "yes", -- Always show sign column to prevent text shifting
        wrap = true, -- Enable line wrapping for long lines
        textwidth = 120, -- Maximum line width for text formatting
        colorcolumn = "120", -- Visual guide for line length
        cursorline = true, -- Highlight current line
        cursorcolumn = false, -- Don't highlight current column (performance)

        -- Scrolling and navigation
        scrolloff = 8, -- Keep 8 lines visible above/below cursor when scrolling
        sidescrolloff = 8, -- Keep 8 columns visible when horizontally scrolling
        smoothscroll = true, -- Smooth scrolling for wrapped lines

        -- File handling and persistence
        undofile = true, -- Enable persistent undo history across sessions
        undolevels = 10000, -- Maximum number of undo levels to store
        undoreload = 10000, -- Maximum lines to save for undo on buffer reload
        autowrite = true, -- Automatically save file before certain commands
        autoread = true, -- Automatically read file when changed outside of vim
        backup = false, -- Don't create backup files
        writebackup = false, -- Don't create temporary backup when writing
        swapfile = false, -- Disable swap files (undofile provides recovery)
        confirm = true, -- Confirm before closing unsaved files

        -- Performance optimizations
        updatetime = 200, -- Faster events (CursorHold, diagnostics) - 200ms
        timeoutlen = 300, -- Faster key sequence timeout
        ttimeoutlen = 10, -- Faster key code timeout
        lazyredraw = false, -- Don't defer screen redraws (better for modern plugins)
        ttyfast = true, -- Assume fast terminal connection for better performance
        synmaxcol = 300, -- Limit syntax highlighting to 300 columns per line
        redrawtime = 1500, -- Time in milliseconds for redrawing the display
        maxmempattern = 20000, -- Maximum memory to use for pattern matching

        -- Buffer and window behavior
        hidden = true, -- Allow hidden buffers with unsaved changes
        splitbelow = true, -- Open horizontal splits below current window
        splitright = true, -- Open vertical splits to the right of current window
        switchbuf = "useopen,usetab", -- Jump to existing buffer/tab when available

        -- Search and completion
        ignorecase = true, -- Case insensitive search
        smartcase = true, -- Case sensitive when uppercase letters are used
        incsearch = true, -- Show search results as you type
        hlsearch = true, -- Highlight search results
        wrapscan = true, -- Search wraps around end of file
        wildmenu = true, -- Enhanced command line completion
        wildmode = "longest:full,full", -- Command completion behavior
        completeopt = "menu,menuone,noselect", -- Completion options

        -- Indentation and formatting
        expandtab = true, -- Use spaces instead of tabs
        tabstop = 2, -- Number of spaces a tab represents
        shiftwidth = 2, -- Number of spaces for each indentation level
        softtabstop = 2, -- Number of spaces for tab in insert mode
        smartindent = true, -- Smart auto indenting
        shiftround = true, -- Round indent to multiple of shiftwidth
        breakindent = true, -- Maintain indent when wrapping lines
        linebreak = true, -- Break lines at word boundaries

        -- Visual and UI improvements
        termguicolors = true, -- Enable 24-bit RGB color
        showmode = false, -- Don't show mode (status line handles this)
        showcmd = true, -- Show command in bottom bar
        cmdheight = 1, -- Height of command line
        pumheight = 15, -- Maximum height of popup menu
        pumblend = 10, -- Transparency for popup menu
        winblend = 0, -- Transparency for floating windows

        -- Spell checking and text
        spell = false, -- Disable spell checking
        spelllang = "en_us", -- Spell check language

        -- Search tools
        grepprg = "rg --vimgrep --no-heading --smart-case", -- Enhanced ripgrep configuration
        grepformat = "%f:%l:%c:%m", -- Format string for ripgrep output parsing

        -- Mouse and interaction
        mouse = "a", -- Enable mouse support in all modes
        mousemodel = "popup", -- Right click opens popup menu

        -- Folding
        foldmethod = "expr", -- Use expression for folding
        foldexpr = "nvim_treesitter#foldexpr()", -- Use treesitter for folding
        foldlevel = 99, -- Start with all folds open
        foldlevelstart = 99, -- Start with all folds open
        foldenable = true, -- Enable folding

        -- Miscellaneous performance and behavior
        laststatus = 3, -- Global statusline
        showtabline = 2, -- Always show tabline
        sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal", -- Session options
        viewoptions = "folds,cursor", -- View options for mkview
        conceallevel = 2, -- Hide syntax elements (useful for markdown)
        concealcursor = "nc", -- When to hide concealed text (normal and command mode)
        list = true, -- Show invisible characters
        listchars = {
          tab = "→ ", -- Show tabs as →
          trail = "•", -- Trailing spaces as •
          extends = "▸", -- Line continues to the right
          precedes = "◂", -- Line continues to the left
          nbsp = "␣", -- Non-breaking spaces
        },
        fillchars = { -- Characters for UI elements
          fold = " ",
          eob = " ", -- End of buffer
          diff = "╱", -- Deleted lines in diff mode
          msgsep = "‾",
          foldopen = "▾",
          foldsep = "│",
          foldclose = "▸",
        },
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

        ["<Leader>gv"] = {
          "<cmd>Gitsigns toggle_current_line_blame<CR>",
          desc = "Toggle Git Blame in Current Line",
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
