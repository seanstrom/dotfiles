vim.cmd('source ~/.config/nvim/vim/init.vim')

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require 'cmp'
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  })
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local nvim_lsp = require("lspconfig")

nvim_lsp.fsautocomplete.setup {
  capabilities = capabilities,
  cmd = { "dotnet", "fsautocomplete", "--background-service-enabled" },
}
