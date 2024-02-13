vim.g.mapleader   = ","

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', ';', ':Buffers', {})
-- map('n', 't', ':Files', {})
-- map('n', 'r', ':Tags', {})
map('n', 'f', ':Rg<Space>', {})

map('i', '<C-p>', '<Up>', {})
map('i', '<C-n>', '<Down>', {})
map('i', '<C-b>', '<Left>', {})
map('i', '<C-f>', '<Right>', {})
map('i', '<C-e>', '<End>', {})
map('i', '<C-a>', '<Home>', {})
map('i', '<C-h>', '<Backspace>', {})
map('i', '<C-d>', '<Del>', {})
map('i', '<C-[>', '<ESC>', {})

map('n', '<Leader>tt', ':Ttoggle<CR>', opts)
map('t', '<Leader>tt', '<C-\\><C-n>:Ttoggle<CR>', opts)

-- buffer
map('n', '[b', ':bprevious<CR>', opts)
map('n', ']b', ':bnext<CR>', opts)
map('n', '[B', ':bfirst<CR>', opts)
map('n', ']B', ':blast<CR>', opts)

-- split window
map('n', '<C-x>1', ':only<CR>', opts)
map('n', '<C-x>2', ':split<CR>', opts)
map('n', '<C-x>3', ':vsplit<CR>', opts)
map('n', '<C-x>4', ':close<CR>', opts)

-- highlight
map('n', '<C-L>', ':noh<C-L><CR>', opts)
