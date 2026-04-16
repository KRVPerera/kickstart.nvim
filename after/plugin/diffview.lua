vim.keymap.set('n', '<leader>gdo', vim.cmd.DiffviewOpen, { desc = '[G]it [D]iffView [O]pen' })
vim.keymap.set('n', '<leader>gde', vim.cmd.DiffviewClose, { desc = '[G]it [D]iffView [E]xit' })
vim.keymap.set('n', '<leader>gdf', vim.cmd.DiffviewFileHistory, { desc = '[G]it [D]iffView [F]ileHistory' })

vim.keymap.set('n', '<leader>gdv', ':DiffviewOpen vnext...HEAD<cr>', { desc = '[G]it [D]iffView [V]next' })
vim.keymap.set('n', '<leader>gdc', ':DiffviewOpen vnext...HEAD<cr>', { desc = '[G]it [D]iffView [C]ezanne' })
