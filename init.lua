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
  "protols",

  -- disable sql for now as it needs more configuration
  -- "sqls",

  -- golangci-lint is enabled by nvim-lint plugin
  -- but keep the configuration here for reference
  -- and if you want to use it directly with some
  -- modifications
  --
  -- "golangci-lint",
})

-- diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    virt_text_pos = "right_align",
  },
  virtual_lines = false,
  underline = true,
  update_in_insert = true,
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

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

local diagnostic_virtual_lines_on = function()
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
  })
end

local diagnostic_virtual_text_on = function()
  vim.diagnostic.config({
    virtual_text = {
      current_line = true,
      virt_text_pos = "right_align",
    },
    virtual_lines = false,
  })
end

local diagnostic_virtual_toggle = function()
  local config = vim.diagnostic.config()

  local has_vlines = type(config.virtual_lines) == "boolean" and config.virtual_lines
    or type(config.virtual_lines) == "table" and not vim.tbl_isempty(config.virtual_lines)

  local has_vtext = type(config.virtual_text) == "boolean" and config.virtual_text
    or type(config.virtual_text) == "table" and not vim.tbl_isempty(config.virtual_text)

  if has_vlines and has_vtext or not has_vlines and not has_vtext then
    diagnostic_virtual_text_on()
  elseif has_vlines then
    diagnostic_virtual_text_on()
  else
    diagnostic_virtual_lines_on()
  end
end

vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [q]uickfix list" })

vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle [d]iagnostic" })

vim.keymap.set("n", "<leader>dv", diagnostic_virtual_toggle, { desc = "Toggle [v]irtual lines <-> text" })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = vim.schedule_wrap(diagnostic_virtual_text_on),
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = vim.schedule_wrap(diagnostic_virtual_text_on),
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    vim.defer_fn(diagnostic_virtual_lines_on, 100)
  end,
})

-- disable default netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_nogx = 1

-- setup conform.nvim for formatting
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("config.lazy")
require("config.keymaps")
