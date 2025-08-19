return {
  --
  -- https://github.com/nvim-lua/plenary.nvim
  --
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  --
  -- https://github.com/mason-org/mason.nvim
  --
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        "actionlint",
        "autotools-language-server",
        "bash-language-server",
        "buf",
        "copilot-language-server",
        "docker-compose-language-service",
        "gh-actions-language-server",
        "golangci-lint-langserver",
        "hadolint",
        "markdown-oxide",
        "markdownlint-cli2",
        "shellcheck",
        "shfmt",
        "sqlfluff",
        "sqls",
        "terraform-ls",
        "typos",
        "vale",
        "yaml-language-server",
        "yamlfmt",
        "yamllint",
        "protols",
      },
    },
    config = function(_, opts)
      require("mason").setup()
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  },

  --
  -- https://github.com/stevearc/overseer.nvim
  --
  {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
      require("overseer").setup()
    end,
  },

  --
  -- https://github.com/nvim-tree/nvim-web-devicons
  --
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  --
  -- https://github.com/tpope/vim-sleuth
  --
  {
    "tpope/vim-sleuth",
    lazy = true,
  },

  --
  -- https://github.com/folke/tokyonight.nvim
  --
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.bg = "#12121a"
      end,

      on_highlights = function(hl, c)
        hl.Directory.fg = "#bccdfb"
        hl.Comment.fg = "#777777"
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  --
  -- https://github.com/norcalli/nvim-colorizer.lua
  --
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
    config = function(_, opts)
      require("colorizer").setup()
    end,
  },

  --
  -- htps://github.com/rcarriga/nvim-notify
  --
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  --
  -- https://github.com/folke/lazydev.nvim
  --
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  --
  -- https://github.com/chrishrb/gx.nvim
  --
  {
    "chrishrb/gx.nvim",
    lazy = false,
    cmd = { "Browse" },
    opts = {
      handlers = {
        go = true,
      },
    },
    keys = {
      { "<leader>gx", "<cmd>Browse<cr>", desc = "Open Link" },
    },
  },

  --
  -- https://github.com/nvim-tree/nvim-tree.lua
  --
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeFocus",
    },
    opts = {},
    keys = {
      {
        "<C-d>",
        function()
          require("nvim-tree.api").tree.toggle({ find_file = true })
        end,
        desc = "Explorer",
      },
      { "<C-e>", "<cmd>NvimTreeFindFile<cr>", desc = "Explorer Find File" },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  --
  -- https://github.com/windwp/nvim-autopairs
  --
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },

  --
  -- https://github.com/MagicDuck/grug-far.nvim
  --
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  --
  -- https://github.com/tpope/vim-fugitive
  --
  {
    "tpope/vim-fugitive",
    lazy = false,
    cmd = { "Git" },
    keys = {
      { mode = "n", "<leader>Gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },

  --
  -- https://github.com/ibhagwan/fzf-lua
  --
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Fzf" },
    opts = {},
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("Highlighter", {}),
        pattern = "markdown",
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })

      require("fzf-lua").setup({ "telescope" })
      require("fzf-lua").register_ui_select()
    end,
    keys = {
      { mode = "n", "<C-p>", "<Cmd>Fzf files<CR>", desc = "Files (Root Dir)" },
      { mode = "n", "<C-g>", "<Cmd>Fzf live_grep<CR>", desc = "Grep Project" },
      { mode = "n", "<F1>", "<Cmd>Fzf help_tags<CR>", desc = "Help Tags" },
      {
        mode = "n",
        "<leader>fw",
        function()
          require("fzf-lua").live_grep({
            query = vim.fn.expand("<cword>"),
          })
        end,
        desc = "Grep word under cursor",
      },
      {
        mode = "n",
        "<leader>fre",
        function()
          require("fzf-lua").lsp_references()
        end,
        desc = "References",
      },
    },
  },

  --
  -- https://github.com/folke/which-key.nvim
  --
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>s", group = "[s]earch and replace" },
          { "<leader>g", group = "[g]olang" },
          { "<leader>G", group = "[G]it" },
          { "<leader>t", group = "[t]ouble" },
        },
      },
      keys = {
        scroll_down = "<c-j>",
        scroll_up = "<c-k>",
      },
    },
    keys = {
      {
        "<leader>h",
        function()
          require("which-key").show({ global = false })
        end,
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  --
  -- https://github.com/L3MON4D3/LuaSnip
  --
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    -- TODO: add snippets
  },

  --
  -- https://github.com/akinsho/toggleterm.nvim
  --
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 30,
    },
    config = true,
  },

  --
  -- https://github.com/Saghen/blink.cmp,
  --
  {
    "saghen/blink.cmp",
    dependencies = {
      { "giuxtaposition/blink-cmp-copilot" },
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },

    version = "1.*",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "super-tab",
        },

        signature = {
          enabled = true,
        },

        appearance = {},

        completion = {
          ghost_text = {
            enabled = true,
          },

          menu = {
            border = nil,
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = nil,
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 200,
          },
        },
        sources = {
          default = {
            "copilot",
            "lazydev",
            "lsp",
            "path",
            "snippets",
            "buffer",
          },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              score_offset = 100,
              async = true,
            },
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 200,
            },
            dadbod = {
              name = "Dadbod",
              module = "vim_dadbod_completion.blink",
            },
          },
          per_filetype = {
            sql = { "snippets", "dadbod", "buffer" },
          },
        },

        fuzzy = {
          implementation = "prefer_rust_with_warning",
        },

        cmdline = {
          enabled = false,
        },
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = "#CBCED8" })
    end,
  },

  --
  -- https://github.com/zbirenbaum/copilot.lua
  --
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 15,
        keymap = {
          accept = false,
        },
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        go = true,
        help = true,
        lua = true,
        make = true,
        markdown = true,
        sh = true,
      },
    },
    config = function()
      require("copilot").setup({})
    end,
  },

  --
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
  --
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      -- { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      auto_insert_mode = true,
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
    end,
  },

  --
  -- https://github.com/nvim-treesitter/nvim-treesitter
  --
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    branch = "master",
    lazy = false,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "go",
        "gomod",
        "gosum",
        "gowork",
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
      },
    },
  },

  --
  -- https://github.com/AndrewRadev/splitjoin.vim
  --
  {
    "AndrewRadev/splitjoin.vim",
  },

  --
  -- https://github.com/ray-x/go.nvim
  --
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gosum" },
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      diagnostic = false,
      lsp_inlay_hints = {
        enable = false,
      },
      trouble = true,
      comment_placeholder = "",
    },
    keys = {
      { mode = "n", "<leader>gcm", "<cmd>GoCmt<cr>", desc = "Add comment" },
      { mode = "n", "<leader>gta", "<cmd>GoAddTag<cr>", desc = "Add tags" },
      { mode = "n", "<leader>gtr", "<cmd>GoRmTag<cr>", desc = "Remove tags" },
      { mode = "n", "<leader>gte", "<cmd>GoTest<cr>", desc = "Run tests" },
      { mode = "n", "<leader>grn", vim.lsp.buf.rename, desc = "[r]e[n]ame" },
      { mode = "n", "<leader>gre", vim.lsp.buf.references, desc = "[r][e]ferences" },
      { mode = "n", "<leader>gat", "<cmd>GoAlt!<cr>", desc = "Toggle test" },
      { mode = "n", "<leader>gas", "<cmd>GoAltS!<cr>", desc = "Toggle split test" },
      { mode = "n", "<leader>gav", "<cmd>GoAltV!<cr>", desc = "Toggle vsplit test" },
    },
    config = function(lp, opts)
      require("go").setup(opts)
    end,
  },

  --
  -- https://github.com/RRethy/vim-illuminate
  --
  {
    "RRethy/vim-illuminate",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  --
  -- https://github.com/monaqa/dial.nvim
  --
  {
    "monaqa/dial.nvim",
    keys = {
      {
        mode = "n",
        "<C-a>",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
      },
      {
        mode = "n",
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
      },
      {
        mode = "n",
        "g<C-a>",
        function()
          require("dial.map").manipulate("increment", "gnormal")
        end,
      },
      {
        mode = "n",
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gnormal")
        end,
      },
      {
        mode = "v",
        "<C-a>",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
      },
      {
        mode = "v",
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "visual")
        end,
      },
      {
        mode = "v",
        "g<C-a>",
        function()
          require("dial.map").manipulate("increment", "gvisual")
        end,
      },
      {
        mode = "v",
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gvisual")
        end,
      },
    },
  },

  --
  -- https://github.com/grafana/vim-alloy
  --
  {
    "grafana/vim-alloy",
    ft = { "alloy", "alloy.vim" },
  },

  --
  -- https://github.com/direnv/direnv.vim
  --
  {
    "direnv/direnv.vim",
    opts = {},
    config = function()
      -- NOTE: this must be empty otherwise lazyvim throws an error
    end,
  },

  --
  -- https://github.com/echasnovski/mini.surround
  --
  {
    "echasnovski/mini.surround",
    optional = true,
    opts = {},
    keys = {
      {
        mode = { "n", "v" },
        "gsa",
        function()
          require("mini.surround").add()
        end,
        desc = "Add Surround",
      },
      {
        mode = { "n", "v" },
        "gsc",
        function()
          require("mini.surround").delete()
        end,
        desc = "Delete Surround",
      },
      {
        mode = { "n", "v" },
        "gsr",
        function()
          require("mini.surround").replace()
        end,
        desc = "Replace Surround",
      },
      {
        mode = { "n", "v" },
        "gss",
        function()
          require("mini.surround").select()
        end,
        desc = "Select Surround",
      },
      {
        mode = { "n", "v" },
        "gsp",
        function()
          require("mini.surround").toggle()
        end,
        desc = "Toggle Surround",
      },
    },
    config = function()
      require("mini.surround").setup()
    end,
  },

  --
  -- https://github.com/tpope/vim-repeat
  --
  {
    "tpope/vim-repeat",
    lazy = true,
  },

  --
  -- https://github.com/folke/todo-comments.nvim
  --
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        multiline = false,
        after = "",
        before = "",
        keyword = "bg",
      },
    },
    config = true,
  },

  --
  -- https://github.com/lewis6991/gitsigns.nvim
  --
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align",
        delay = 1000,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
      },

      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghB", function()
          gs.blame()
        end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  --
  -- https://github.com/kristijanhusak/vim-dadbod-ui
  --
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    -- TODO::
    -- - expand schema by default
    -- - expand tables view by default
    -- - sqlc integration
    keys = {
      -- {
      --   "<space>",
      --   "<Plug>(DBUI_ToggleResultLayout)",
      --   desc = "Toggle Database UI",
      -- },
    },
  },

  --
  -- https://github.com/nvim-lualine/lualine.nvim
  --
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
      sections = {
        lualine_x = {},
      },
    },
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },

  --
  -- https://github.com/mfussenegger/nvim-lint
  --
  {
    "mfussenegger/nvim-lint",
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        docker = { "hadolint" },
        go = { "golangcilint" },
        terraform = { "terraform_validate", "tflint", "tfsec" },
        -- sql = { "sqlfluff" },
        markdown = { "markdownlint-cli2" },
        yaml = { "yamllint" },
        ["yaml.gh_actions"] = { "actionlint" },
        ["yaml.ghaction"] = { "actionlint" },
        shell = { "shellcheck" },
        ["*"] = { "typos" },
      },
      linters = {
        golangcilint = {
          args = {
            "run",
            "--output.json.path=stdout",
            -- Overwrite values possibly set in .golangci.yml
            "--output.text.path=",
            "--output.tab.path=",
            "--output.html.path=",
            "--output.checkstyle.path=",
            "--output.code-climate.path=",
            "--output.junit-xml.path=",
            "--output.teamcity.path=",
            "--output.sarif.path=",
            "--issues-exit-code=0",
            "--show-stats=false",
            -- Get absolute path of the linted file
            "--path-mode=abs",
            function()
              return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
            end,
          },
        },
      },
      custom = {
        golangcilint = {
          -- golangci-lint does not support go submodules and go.work files
          -- so we need to find the first go.mod file in the current directory
          -- or any parent directory, otherwise golangci is run in the
          -- directory where nvim is opened. If this is outside the
          -- current file go.mod (e.g. in the project root dir where go.work lives),
          -- then the linter will not work correctly.
          cwd = function()
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir = vim.fn.fnamemodify(current_file, ":h")

            local gomod_file = vim.fs.find("go.mod", {
              path = current_dir,
              upward = true,
              type = "file",
            })[1]

            if gomod_file and vim.fn.filereadable(gomod_file) == 1 then
              return vim.fn.fnamemodify(gomod_file, ":h")
            end

            return current_dir
          end,
        },
      },
    },
    config = function(_, opts)
      local M = {}
      local lint = require("lint")

      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        if #names > 0 then
          -- check if naems contains golangcilint, then set the cwd
          local lintopts = {}
          if vim.tbl_contains(names, "golangcilint") then
            lintopts = { cwd = opts.custom.golangcilint.cwd() }
          end

          lint.try_lint(names, lintopts)
        end
      end

      -- customize typos-cli and load config
      -- 1. travers up the path to find typos.toml
      -- 2. config file is loaded from ~/.config/typos/typos.toml
      local typos = require("lint").linters.typos
      if type(typos) ~= "table" then
        vim.notify("nvim-lint: typos linter not found", vim.log.levels.WARN)
        return
      end

      local typos_cfg = vim.fs.find("typos.toml", {
        path = vim.fn.expand("%:p:h"),
        upward = true,
        type = "file",
      })[1]

      if vim.fn.filereadable(typos_cfg) == 0 then
        typos_cfg = vim.fn.expand("~/.config/typos/typos.toml")
      end

      if vim.fn.filereadable(typos_cfg) == 1 then
        table.insert(typos.args, "--config")
        table.insert(typos.args, typos_cfg)
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },

  --
  -- https://github.com/rshkarin/mason-nvim-lint
  --
  {
    "rshkarin/mason-nvim-lint",
    dependencies = { "mason.nvim", "nvim-lint" },
    config = function()
      require("mason-nvim-lint").setup({
        quiet_mode = true,
      })
    end,
  },

  --
  -- https://github.com/stevearc/conform.nvim
  --
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = false,
    opts = {
      log_level = vim.log.levels.DEBUG,
      format_on_save = {
        async = false,
        timeout_ms = 2500,
        lsp_fallback = "fallback",
        quiet = false,
      },
      formatters_by_ft = {
        sh = { "shfmt" },
        go = { "goimports", "golangci-lint" },
        lua = { "stylua" },
        proto = { "buf" },
        yaml = { "yamlfmt" },
        sql = { "sqlfluff" },
        markdown = { "markdownlint-cli2" },
        tf = { "terraform_fmt" },
      },
    },
  },

  --
  -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
  --
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      require("harpoon").setup(opts)
    end,
  },

  --
  -- https://github.com/jake-stewart/multicursor.nvim
  --
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<down>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<leader><up>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<leader><down>", function()
        mc.lineSkipCursor(1)
      end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>n", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<leader>s", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "<leader>N", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<leader>S", function()
        mc.matchSkipCursor(-1)
      end)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },

  --
  -- https://github.com/gbprod/yanky.nvim
  --
  {
    "gbprod/yanky.nvim",
    opts = {},
    keys = {
      { "<leader>y", "<cmd>YankyRingHistory<cr>", mode = { "n", "x" }, desc = "Open Yank History" },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },

      -- { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
      -- { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
    },
  },

  --
  -- https://github.com/folke/trouble.nvim
  --
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", desc = "[d]iagnostics toggle" },
      { "<leader>tt", "<cmd>Trouble todo toggle<cr>", desc = "[t]odo toggle" },
      { "<leader>tl", "<cmd>Trouble lsp toggle<cr>", desc = "[l]sp toggle" },
      { "<leader>tc", "<cmd>Trouble close<cr>", desc = "[c]lose" },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
}
