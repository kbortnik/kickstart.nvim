vim.keymap.set('n', '+', '<C-w>+')
vim.keymap.set('n', '-', '<C-w>-')
vim.keymap.set('n', '<C-j>', ':ToggleTerm<CR>')

-- Move selected line / block of text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle of the screen when jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

vim.api.nvim_set_keymap('n', '<leader>tw', "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", {})
