-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- faster save, write and quit commands
vim.keymap.set("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit current file" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit all windows" })
vim.keymap.set("n", "<leader>co", "<cmd>close<CR>", { desc = "Close current window" })

vim.keymap.set("n", "<leader>y", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keymaps for Go commands
-- vim.keymap.set('i', '<C-e>', '<Esc>:GoIfErr<CR>i', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-b>', ':GoBuild<CR>', { noremap = true, silent = true })

-- vim.keymap.set('n', '<F2>', '<Plug>(go-rename)', { noremap = true, silent = true })
-- vim.keymap.set('n', '<F3>', '<Plug>(go-referrers)', { noremap = true, silent = true })

-- Keymaps for diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "<leader>dt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle Diagnostics" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without yanking" })

function get_git_root_or_buffer_dir()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

  local makefile_file = vim.fs.find("Makefile", {
    path = current_dir,
    upward = true,
    type = "file",
  })[1]

  if makefile_file then
    return vim.fn.fnamemodify(makefile_file, ":h")
  end

  return "git_root"
end

function _terminal_toggle()
  local terminal = require("toggleterm.terminal").Terminal:new({
    dir = get_git_root_or_buffer_dir(),
  })
  terminal:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>lua _terminal_toggle()<CR>", { noremap = true, silent = true })
