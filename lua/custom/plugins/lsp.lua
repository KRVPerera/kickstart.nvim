-- Language servers, Mason tools and formatting rules on top of kickstart's LSP setup in init.lua

---@type table<string, vim.lsp.Config>
local servers = {
  clangd = {},
  rust_analyzer = {},
  cmake = {},
  markdown_oxide = {},
  yamlls = {},
  cssls = {},
  ts_ls = {},
  html = {},

  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'E266', 'E501' },
            maxLineLength = 180,
          },
          autopep8 = {},
          flake8 = {
            maxLineLength = 180,
          },
          mccabe = {
            maxLineLength = 180,
          },
          pylint = {
            maxLineLength = 180,
          },
        },
      },
    },
  },

  -- Merged into kickstart's lua_ls config
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- Replaces kickstart's list; the tool list is read once Neovim has started
require('mason-tool-installer').setup {
  ensure_installed = {
    'clangd',
    'cmake-language-server',
    'lua-language-server',
    'markdown-oxide',
    'rust-analyzer',
    'stylua',
  },
}

-- Replaces kickstart's format-on-save rule: format everything except c/cpp/cmake
require('conform').setup {
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true, cmake = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return { timeout_ms = 500 }
    end
  end,
}
