call plug#begin('~/.vim/plugged')

if filereadable(expand('~/.vimrc.plugins'))
  so ~/.vimrc.plugins
endif

call plug#end()
