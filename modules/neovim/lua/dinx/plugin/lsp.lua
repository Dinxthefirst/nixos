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
local servers = {
  lua_ls = { cmd = { 'lua-language-server' }, filetypes = { 'lua' }, root_markers = { '.luarc.json', '.git' } },
  nil_ls = { cmd = { 'nil' }, filetypes = { 'nix' }, root_markers = { 'flake.nix', '.git' } },
  -- ts_ls = { cmd = { 'typescript-language-server', '--stdio' }, filetypes = { 'typescript', 'javascript' }, root_markers = { 'tsconfig.json', '.git' } },
  rust_ls = { cmd = { 'rust-analyzer' }, filetypes = { 'rust' }, root_markers = { 'cargo.toml', '.git' } },
}

for name, cfg in pairs(servers) do
  vim.lsp.config(name, vim.tbl_extend('force', cfg, {
    capabilities = caps,
    on_attach    = on_attach,
  }))
end