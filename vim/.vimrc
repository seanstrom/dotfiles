" Environment
set rtp+=~/.vim/
set shell=bash
set shell=$SHELL


" Load Plugins
so ~/.vim/plugins.vim


" Enable syntax highlighting
syntax enable


" Indentation
filetype plugin indent on


" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure


" General
set backspace=2       " Make backspace delete
" set clipboard=unnamed " Make vim share clipboard with system
set clipboard^=unnamed,unnamedplus


" Tab indenting
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set ai " Autoindent
set si " Smart indent


" Appearance
set showtabline=2   " Always show tab bar
set laststatus=2    " Always show the statusline
set ttimeoutlen=50  " Set timeout length
set number          " Show line numbers
set title           " Display filename in title bar
set scrolloff=5     " set minimum space between the cursor and window
" set cursorline      " Adds highlighted line on current line
" set cursorcolumn    " Adds highlighted line on current column


" Keep temp files out of CWD
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swp
set undodir=~/.vim/tmp/undo


" Searching
set hlsearch   " Highlight found searches
set ignorecase " Ignore case in searched
set smartcase  " Don't ignore case if searching with caps
set incsearch  " Incrementally search


" Misc
set nobackup        " Don't create backup files
set spelllang=en_us " Set spell check language
set nowrap          " Disable line wrapping
set ttyfast
set autoread        " Read changes on a file when it is changed


" Folding
set foldmethod=syntax
set foldlevel=99


" Show Invisibles
set list
set listchars=tab:\ »


" Theme Settings
if filereadable(expand('~/.vimrc.theme'))
  so ~/.vimrc.theme
endif


" Local Ovverides
if filereadable(expand('~/.vimrc.local'))
  so ~/.vimrc.local
endif


" Minimap
let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 0
let g:minimap_block_filetypes = ['startify', 'minimap', 'nofile']
let g:minimap_close_filetypes = ['netrw', 'vim-plug']


" Hide ~ for end of buffer character
let &fcs='eob: '


" Fuzzy Finder FZF
nnoremap <leader>p :GFiles<CR>
nnoremap <leader><CR> :Buffers<CR>

