vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("let g:polyglot_disabled = ['ftdetect', 'autoindent']")

vim.cmd('source ~/.config/nvim/vim/init.vim')

require('gitsigns').setup()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require 'cmp'

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'conjure' },
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

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = require("lspconfig")
local nvim_format = require("lsp-format")

nvim_format.setup({}) 

nvim_lsp.fsautocomplete.setup {
  capabilities = capabilities,
  cmd = { "dotnet", "fsautocomplete", "--background-service-enabled" },
}

nvim_lsp["zls"].setup({
  capabilities = capabilities
})

nvim_lsp["clangd"].setup({
  capabilities = capabilities,
  cmd = {"clangd", "--compile-commands-dir=./"}
})

nvim_lsp["clojure_lsp"].setup({
  capabilities = capabilities,
  on_attach = nvim_format.on_attach,
})

nvim_lsp.elmls.setup({ capabilities = capabilities, on_attach = nvim_format.on_attach })

-- Treesitter Setup

local treesitter = require('nvim-treesitter.configs')
treesitter.setup({
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "javascript", "elm", "clojure", "lua", "fennel", "python", "c_sharp", "rust", "cpp", "html", "css" }
})

