-- vim.cmd("let g:polyglot_disabled = ['ftdetect', 'autoindent']")

if vim.g.vscode then
  vim.cmd('source ~/.vimrc.local')
  vim.cmd('set clipboard+=unnamedplus')
else
  vim.cmd('source ~/.config/nvim/vim/init.vim')
end

require("bootstrap")
