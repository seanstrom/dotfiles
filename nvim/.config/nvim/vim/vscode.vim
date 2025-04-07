source ~/.vimrc.local
set clipboard+=unnamedplus

call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'Olical/nfnl'
  Plug 'guns/vim-sexp'
  Plug 'tpope/vim-sexp-mappings-for-regular-people'
end
call plug#end()
