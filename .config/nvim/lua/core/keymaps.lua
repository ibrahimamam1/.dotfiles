-- ~/.config/nvim/lua/core/keymaps.lua

local opts = { noremap = true, silent = true }

-- Move to previous/next
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Goto buffer in position...
vim.keymap.set('n', '<Space>1', '<Cmd>BufferGoto 1<CR>', opts)
vim.keymap.set('n', '<Space>2', '<Cmd>BufferGoto 2<CR>', opts)
vim.keymap.set('n', '<Space>3', '<Cmd>BufferGoto 3<CR>', opts)
vim.keymap.set('n', '<Space>4', '<Cmd>BufferGoto 4<CR>', opts)
vim.keymap.set('n', '<Space>5', '<Cmd>BufferGoto 5<CR>', opts)
vim.keymap.set('n', '<Space>6', '<Cmd>BufferGoto 6<CR>', opts)
vim.keymap.set('n', '<Space>7', '<Cmd>BufferGoto 7<CR>', opts)
vim.keymap.set('n', '<Space>8', '<Cmd>BufferGoto 8<CR>', opts)
vim.keymap.set('n', '<Space>9', '<Cmd>BufferGoto 9<CR>', opts)
vim.keymap.set('n', '<Space>0', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Close buffer
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
vim.keymap.set('n', '<A-s-c>', '<Cmd>BufferRestore<CR>', opts)

-- Sort automatically by...
vim.keymap.set('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
vim.keymap.set('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
