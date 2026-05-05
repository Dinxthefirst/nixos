local lsp = require('lspconfig')
local caps = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, buf)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = buf, desc = desc })
  end
  map('gd',        vim.lsp.buf.definition,       'Go to definition')
  map('gr',        vim.lsp.buf.references,       'References')
  map('K',         vim.lsp.buf.hover,            'Hover docs')
  map('<leader>rn', vim.lsp.buf.rename,          'Rename')
  map('<leader>ca', vim.lsp.buf.code_action,     'Code action')
  map('<leader>f',  vim.lsp.buf.format,          'Format')
end

-- Add each LSP from extraPackages
local servers = { 'lua_ls', 'nil_ls' }
for _, server in ipairs(servers) do
  lsp[server].setup { capabilities = caps, on_attach = on_attach }
end