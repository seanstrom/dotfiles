set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

let g:neovide_padding_top=0
let g:neovide_padding_left=28
let g:neovide_padding_right=28
let g:neovide_padding_bottom=0

nnoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>
