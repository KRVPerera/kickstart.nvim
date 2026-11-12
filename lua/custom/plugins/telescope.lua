-- Telescope additions on top of kickstart's setup in init.lua:
-- prompt history/refine mappings and the live-grep-args extension

vim.pack.add { { src = 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim', version = vim.version.range '1.*' } }

local lga_actions = require 'telescope-live-grep-args.actions'

-- Calling setup again replaces kickstart's telescope config, so ui-select is repeated here
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<c-space>'] = 'to_fuzzy_refine',
        ['<C-Down>'] = require('telescope.actions').cycle_history_next,
        ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
      },
    },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = { -- extend mappings
        i = {
          ['<C-k>'] = lga_actions.quote_prompt(),
          ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
          -- freeze the current list and start a fuzzy search in the frozen list
          ['<C-space>'] = lga_actions.to_fuzzy_refine,
        },
      },
      theme = 'dropdown', -- use dropdown theme
      layout_config = { mirror = true, preview_cutoff = 20 }, -- mirror preview pane
    },
  },
}
pcall(require('telescope').load_extension, 'live_grep_args')

local builtin = require 'telescope.builtin'
local live_grep_args_shortcuts = require 'telescope-live-grep-args.shortcuts'
vim.keymap.set('n', '<leader>fg', function() require('telescope').extensions.live_grep_args.live_grep_args() end, { desc = '[G]rep' })
vim.keymap.set('n', '<leader>sG', function() require('telescope').extensions.live_grep_args.live_grep_args() end, { desc = '[S]earch with [G]rep args' })
vim.keymap.set('n', '<leader>gw', live_grep_args_shortcuts.grep_word_under_cursor, { desc = '[G]rep [W]ord' })
vim.keymap.set('n', '<leader>gb', live_grep_args_shortcuts.grep_word_under_cursor_current_buffer, { desc = '[G]rep [B]uffer' })
vim.keymap.set('v', '<leader>gv', live_grep_args_shortcuts.grep_visual_selection, { desc = '[G]rep [V]isual' })
vim.keymap.set('n', '<leader>sF', function() builtin.find_files { no_ignore = true, hidden = true } end, { desc = '[S]earch all [F]iles (incl ignored/hidden)' })
