-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- faster save, write and quit commands
vim.keymap.set("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit current file" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit all windows" })
vim.keymap.set("n", "<leader>co", "<cmd>close<CR>", { desc = "Close current window" })

vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without yanking" })

function get_git_root_or_buffer_dir()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

  local makefile_file = vim.fs.find("Makefile", {
    path = current_dir,
    upward = true,
    type = "file",
  })[1]

  if makefile_file and vim.fn.filereadable(makefile_file) == 1 then
    return vim.fn.fnamemodify(makefile_file, ":h")
  end

  return "git_dir"
end

function _terminal_toggle()
  local terminal = require("toggleterm.terminal").Terminal:new({
    dir = get_git_root_or_buffer_dir(),
  })
  terminal:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>lua _terminal_toggle()<CR>", { noremap = true, silent = true })
