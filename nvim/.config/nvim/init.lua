-- vim.cmd("let g:polyglot_disabled = ['ftdetect', 'autoindent']")


if vim.g.vscode then
  -- VSCode extension
  -- undo/REDO via vscode
  vim.keymap.set("n","u","<Cmd>call VSCodeNotify('undo')<CR>")
  vim.keymap.set("n","<C-r>","<Cmd>call VSCodeNotify('redo')<CR>")

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.keymap.set("n", "<leader>ee", "<Cmd>call VSCodeNotify('calva.evaluateSelection')<CR>")
  vim.keymap.set("n", "<leader>e<esc>", "<Cmd>call VSCodeNotify('calva.clearInlineResults')<CR>")
  vim.keymap.set("n", "<leader>ef", "<Cmd>call VSCodeNotify('calva.loadFile')<CR>")

  vim.cmd('source ~/.vimrc.local')
else

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

  local treesitter = require('nvim-treesitter.configs')
  treesitter.setup({
    highlight = {
      enable = true,
      -- additional_vim_regex_highlighting = true,
      additional_vim_regex_highlighting = {'clojure'},
    },
    indent = { enable = true },
    ensure_installed = {  "javascript", "elm", "clojure", "lua", "fennel", "python", "c_sharp", "rust", "cpp", "html", "css", "zig", "comment" },
    matchup = {
      enable = true,
    },
  })

  require('catppuccin').setup({
    color_overrides = {
      all = {
      },
      latte = {
        -- base = "#E3DDBC",
        -- base = "#BFCFC4",
        -- base = "#A2ABB8",
        base = "#B8BF97",
        text = "#1F1F1F"
      },
    },
  })
end
