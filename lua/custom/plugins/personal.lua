-- Extra plugins on top of kickstart. Keymaps for several of these live in after/plugin/

local function gh(repo) return 'https://github.com/' .. repo end

-- Build markdown-preview after it is installed or updated.
-- Must be registered before the vim.pack.add below so the first install triggers it.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name ~= 'markdown-preview.nvim' or (kind ~= 'install' and kind ~= 'update') then return end

    if vim.fn.executable 'npx' == 1 then
      local result = vim.system({ 'npx', '--yes', 'yarn', 'install' }, { cwd = vim.fs.joinpath(ev.data.path, 'app') }):wait()
      if result.code ~= 0 then vim.notify('Build failed for ' .. name .. ':\n' .. (result.stderr or ''), vim.log.levels.ERROR) end
    else
      vim.cmd.packadd 'markdown-preview.nvim'
      vim.fn['mkdp#util#install']()
    end
  end,
})

-- Local harpoon checkout, loaded straight from disk so edits apply without reinstalling
vim.opt.runtimepath:prepend '/home/krv/projects/harpoon'

vim.pack.add { gh 'MeanderingProgrammer/markdown.nvim' }
require('render-markdown').setup {}

vim.pack.add { gh 'iamcco/markdown-preview.nvim' }
vim.g.mkdp_filetypes = { 'markdown' }

vim.pack.add { gh 'folke/twilight.nvim', gh 'folke/zen-mode.nvim' }
require('twilight').setup {}
require('zen-mode').setup {}

vim.pack.add {
  gh 'ThePrimeagen/vim-be-good',
  gh 'mbbill/undotree',
  gh 'voldikss/vim-floaterm',
  gh 'vuciv/golf',
  gh 'mfukar/robotframework-vim',
}

vim.pack.add { gh 'nvim-lualine/lualine.nvim' }
require('lualine').setup {
  options = { theme = 'everforest' },
}

vim.pack.add { gh 'sindrets/diffview.nvim', gh 'NeogitOrg/neogit' }

-- VimTeX reads its options when it loads, so set them before adding it
vim.g.vimtex_view_method = 'zathura'
vim.pack.add { gh 'lervag/vimtex' }

vim.pack.add { { src = gh 'polarmutex/git-worktree.nvim', version = vim.version.range '2.*' } }
vim.keymap.set('n', '<leader>sr', function() require('telescope').extensions.git_worktree.git_worktree() end, { desc = '[S]witch workt[r]ee ' })
vim.keymap.set('n', '<leader>sR', function() require('telescope').extensions.git_worktree.create_git_worktree() end, { desc = '[S]witch workt[R]ee ' })

vim.pack.add { gh 'MunifTanjim/nui.nvim', gh 'rcarriga/nvim-notify', gh 'folke/noice.nvim' }
require('noice').setup {}

vim.pack.add { gh 'rmagatti/auto-session' }
require('auto-session').setup {
  suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  session_lens = {
    load_on_setup = true,
    previewer = false,
    mappings = {
      -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
      delete_session = { 'i', '<C-D>' },
      alternate_session = { 'i', '<C-S>' },
      copy_session = { 'i', '<C-Y>' },
    },
    theme_conf = {
      border = true,
    },
  },
  pre_restore_cmds = {
    -- might not be necessary, but save current harpoon data when we're about to restore a session
    function() require('harpoon'):sync() end,
  },
  post_restore_cmds = {
    function()
      local harpoon = require 'harpoon'

      -- this is the only way i found to force harpoon to reread data from the disk rather
      -- than using what's in memory
      harpoon.data = require('harpoon.Data').Data:new(harpoon.config)
    end,
  },
}
vim.keymap.set('n', '<leader>wr', '<cmd>SessionSearch<CR>', { desc = 'Session search' })
vim.keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'Save session' })
vim.keymap.set('n', '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', { desc = 'Toggle autosave' })
