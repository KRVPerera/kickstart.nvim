return {
  'run-yaml',
  dir = '.',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'yaml',
      callback = function()
        if vim.fn.expand('%:p'):match('^/home/krv/yamls/') then
          vim.keymap.set('n', '<leader>r', function()
            local output = vim.fn.system('~/yamls/run.sh ' .. vim.fn.shellescape(vim.fn.expand('%:p')))
            vim.cmd('new')
            vim.bo.buftype = 'nofile'
            vim.bo.bufhidden = 'wipe'
            vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n'))
          end, { buffer = true, desc = 'Run YAML with run.sh' })
        end
      end,
    })
  end,
}
