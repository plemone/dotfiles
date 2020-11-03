local vim = vim

local set_keymap = function(mode, key, action)
    vim.api.nvim_set_keymap(mode, key, action, {
        noremap = true,
        silent = true,
    })
end

-- Set leader key
set_keymap('n', '<Space>', '<NOP>')
set_keymap('n', ',', '<NOP>')
vim.g.mapleader = ','

-- Better indenting
set_keymap('v', '<', '<gv')
set_keymap('v', '>', '>gv')

-- Move selected line / block of text in visual mode
set_keymap('x', 'K', ':move \'<-2<CR>gv-gv')
set_keymap('x', 'J', ':move \'>+1<CR>gv-gv')

-- Centers the line as you iterate
set_keymap('n', 'n', 'nzzzv')
set_keymap('n', 'N', 'Nzzzv')

-- Toggle window focus
set_keymap('n', '\\', ':winc w<CR>')

-- Delete current buffer
set_keymap('n', '<leader>q', ':bp | sp | bn | bd<CR>')

-- Delete current window
set_keymap('n', '<leader><ESC>', ':q<CR>')
set_keymap('v', '<leader><ESC>', ':q<CR>')

-- Delete contents without putting the in a register
set_keymap('n', '<leader>d', '"_d')
set_keymap('v', '<leader>d', '"_d')

-- Clean up search highlights
set_keymap('n', '<leader>c', ':Actions clear<CR>')

-- Refresh neovim
set_keymap('n', '<leader>r', ':Actions refresh<CR>')

-- Shortcuts to save
set_keymap('n', '<leader><leader>', ':Actions save<CR>')

-- Explorer Tree
set_keymap('n', '<Leader><space>', ':Actions toggle_tree<CR>')

-- Hop
set_keymap('n', '<Leader>z', ':HopWord<CR>')

-- Telescope
set_keymap('n', '<leader>.', ':Actions git_status<CR>')
set_keymap('n', '<leader>h', ':Actions help_tags<CR>')
set_keymap('n', '<leader>l', ':Actions find_files<CR>')
set_keymap('n', '<leader>/', ':Actions live_grep<CR>')
set_keymap('n', '<leader><TAB>', ':Actions list_buffers<CR>')

-- Quickfix
set_keymap('n', '<space>j', ':cn<CR>')
set_keymap('n', '<space>k', ':cp<CR>')

-- Buffer navigation
set_keymap('n', '<c-h>', ':bp<CR>')
set_keymap('n', '<c-l>', ':bn<CR>')
