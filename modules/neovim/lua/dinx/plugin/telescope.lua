local builtin = require('telescope.builtin')
local map = vim.keymap.set

map('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
map('n', '<leader>pg', builtin.git_files, { desc = 'Git files' })
map('n', '<leader>ps', builtin.live_grep, { desc = 'Live grep' })