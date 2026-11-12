-- Search with ripgrep arguments (e.g. `foo -g *.lua`)
-- The extension itself is installed and configured in the Telescope section of init.lua
vim.keymap.set('n', '<leader>sG', function() require('telescope').extensions.live_grep_args.live_grep_args() end, { desc = '[S]earch with [G]rep args' })
