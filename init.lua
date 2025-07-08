-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- setup nerd fonts
vim.g.have_nerd_font = true

-- true color support
vim.o.termguicolors = true

-- show line numbers
vim.o.number = true

-- enable mouse support
vim.o.mouse = "a"

-- do not show the mode in the command line
vim.o.showmode = false

-- decrease update time
vim.o.updatetime = 200

-- decrease mapped sequence wait time
vim.o.timeoutlen = 1000

-- smart case for search
vim.o.ignorecase = true
vim.o.smartcase = true

-- do not create a backup file
vim.o.writebackup = false

-- disable swap files
vim.o.swapfile = false

-- set tab width to 2 spaces
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- indent settings
vim.o.smartindent = true
vim.o.autoindent = true

-- wrap lines at convenient points
vim.o.linebreak = true

-- write all
vim.o.autowriteall = true

-- enable highlighting of the current line
vim.o.cursorline = true

-- always show the signcolumn, otherwise it would shift the text each time
vim.o.signcolumn = "yes"

-- sync clipboard with system clipboard
vim.o.clipboard = "unnamedplus"

-- use ripgrep for searching
vim.o.grepprg = "rg --vimgrep"

-- configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- global statusline for last window
vim.o.laststatus = 3

vim.o.completeopt = "menu,menuone,noselect"

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- command-line completion mode
vim.o.wildmode = "longest:full,full"

-- disable the default ruler
vim.o.ruler = false

-- maximum number of entries in a popup
vim.o.pumheight = 10

-- min/max lines of context
vim.o.scrolloff = 8

-- round indent
vim.o.shiftround = true

-- minimum window width
vim.o.winminwidth = 5

-- disable line wrap
vim.o.wrap = false

vim.o.splitkeep = "screen"

vim.o.shortmess = "ltToOCFIcWC"

vim.o.clipboard = "unnamedplus" -- Sync with system clipboard

vim.lsp.enable({
  "bash",
  "buf",
  "docker-compose",
  "gh-actions",
  "go",
  "json",
  "yaml",

  -- disable sql for now as it needs more configuration
  -- "sqls",

  -- golangci-lint is enabled by nvim-lint plugin
  -- but keep the configuration here for reference
  -- and if you want to use it directly with some
  -- modifications
  --
  -- "golangci-lint",
})

vim.diagnostic.config({
  virtual_lines = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

-- disable default netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_nogx = 1

-- setup conform.nvim for formatting
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("config.lazy")
require("config.keymaps")
