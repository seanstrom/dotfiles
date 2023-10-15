" Environment
set rtp+=~/.vim/
set shell=$SHELL
set shell=sh


" Load Plugins
so ~/.vim/plugins.vim


" Enable syntax highlighting
syntax enable


" Indentation
filetype plugin indent on


" https://andrew.stwrt.ca/posts/project-specific-vimrc/
" set exrc
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
" set showtabline=2   " Always show tab bar
set showtabline=0   " Always hide tab bar
set laststatus=2    " Always show the statusline
set ttimeoutlen=50  " Set timeout length
set number          " Show line numbers
set nonumber
set title           " Display filename in title bar
set notitle
set scrolloff=5     " set minimum space between the cursor and window
" set cursorline      " Adds highlighted line on current line
" set cursorcolumn    " Adds highlighted line on current column
set signcolumn=yes

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


" Show Invisibles
set list
set listchars=tab:\ »


" Hide ~ for end of buffer character
let &fcs='eob: '


" Set height of command line
set cmdheight=1


" Allow Fennel code to run 
let g:aniseed#env = v:true


" Terminal Settings

" Hide line numbers in terminal mode
autocmd TermOpen * setlocal nonumber norelativenumber

" Disable indent lines for terminal buffers
autocmd TermOpen * IndentLinesDisable

" enter insert mode whenever we're in a terminal
autocmd TermOpen,BufWinEnter,BufEnter term://* startinsert


" CPP settings
au BufRead,BufNewFile *.mpp set filetype=cpp


" Clojure settings
" au! BufRead,BufNewFile *.clj* set iskeyword-=-


" Minimap
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0
let g:minimap_block_filetypes = ['startify', 'minimap', 'nofile']
let g:minimap_close_filetypes = ['netrw', 'vim-plug']


" Keybindings

" Remap leader keys to space
" let g:mapleader = " "
" let g:maplocalleader = " "
let g:mapleader = "\<space>"
let g:maplocalleader = "\<space>"

nnoremap <leader>sv :source $MYVIMRC<CR>

if has("nvim")
  " Disable vim-polyglot file and indentation detection for neovim treesitter
  let g:polyglot_disabled = ['ftdetect', 'autoindent']


  " Treesitter Folding
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=99


  " Telescope
  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fl <cmd>Telescope git_files show_untracked=true<cr>
  nnoremap <leader>fx <cmd>Telescope treesitter<cr>
  nnoremap <leader>ft <cmd>Telescope file_browser<cr>
  nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
  nnoremap <leader>fw <cmd>Telescope lsp_workspace_symbols<cr>
  nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
  nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
  nnoremap <leader><TAB> :Telescope telescope-tabs list_tabs<CR>
else
  " Backup VIM keybindings
 
  " Fuzzy Finder FZF
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
  " nnoremap <leader>p :GFiles --cached --others --exclude-standard<CR>
  " nnoremap <leader><CR> :Buffers<CR>
  " nnoremap <leader>f :Files<CR>
endif

" Binding Ctr-s and Cmd-s to save files in normal mode and insert mode
noremap <D-s> :w<CR>
map <C-s> <D-s>
imap <C-s> <ESC><D-s>a
imap <D-s> <ESC><D-s>a

noremap <leader>ww <C-w>x
noremap <C-w> :q<CR>
noremap <leader>q :qa<CR>
inoremap <a-left> <c-left>
inoremap <a-right> <c-right>
inoremap <a-up> <c-up>
inoremap <a-down> <c-down>

nnoremap <leader>tt g<Tab>
nnoremap <leader>tl :tabn<CR>
nnoremap <leader>te :tabn<CR>
nnoremap <leader>th :tabp<CR>
nnoremap <leader>tb :tabp<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
tnoremap <Esc> <C-\><C-n>

" Tmux Navigation
nnoremap <silent> <C-h> <Cmd>TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> <Cmd>TmuxNavigateDown<CR>
nnoremap <silent> <C-k> <Cmd>TmuxNavigateUp<CR>
nnoremap <silent> <C-l> <Cmd>TmuxNavigateRight<CR>

" Theme Settings
if filereadable(expand('~/.vimrc.theme'))
  so ~/.vimrc.theme
endif


" Local Ovverides
if filereadable(expand('~/.vimrc.local'))
  so ~/.vimrc.local
endif
