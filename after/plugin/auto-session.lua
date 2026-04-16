require('auto-session').setup {
  pre_restore_cmds = {
    -- might not be necessary, but save current harpoon data when we're about to restore a session
    function()
      require('harpoon'):sync()
    end,
  },
  post_save_cmds = {
    function()
      -- vim.notify('calling harpoon sync after restore')
      local harpoon = require 'harpoon'

      -- this is the only way i found to force harpoon to reread data from the disk rather
      -- than using what's in memory
      harpoon.data = require('harpoon.Data').Data:new(harpoon.config)
    end,
  },
}
