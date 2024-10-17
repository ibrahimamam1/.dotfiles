-- configure vim options we want
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Enable line numbering
vim.wo.number = true

-- Set a keymap to open a terminal in a split window
vim.keymap.set('n', '<leader>ht', ':botright split | terminal<CR>', { noremap = true, silent = true })

-- Optional: Set a keymap to open a terminal in a vertical split
vim.keymap.set('n', '<leader>vt', ':botright vsplit | terminal<CR>', { noremap = true, silent = true })

-- Optional: Configure terminal settings
vim.cmd([[
  " Set terminal to start in insert mode
  autocmd TermOpen * startinsert

  " Set terminal to hide line numbers
  autocmd TermOpen * setlocal nonumber norelativenumber

  " Set a keymap to exit terminal mode
  tnoremap <Esc> <C-\><C-n>
]])

-- Set a keymap to close the terminal from normal mode
vim.keymap.set('n', '<leader>tq', ':q!<CR>', { noremap = true, silent = true })
