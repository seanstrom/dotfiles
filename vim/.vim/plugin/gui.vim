set guifont=Iosevka_Nerd_Font_Mono

if (has('gvim'))
  set guifont="Iosevka Term:h16"
endif

if (has("nvim"))
  let g:indentLine_char = '│'
  let g:indentLine_first_char = '│'
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_color_gui = "#3C3836"
  let g:indentLine_fileTypeExclude = ['startify']
end

if (has('gui_macvim') || has('gui_running'))
  set guifont="Iosevka Term:h16"
  set guicursor+=a:blinkon0

  let g:indentLine_char = '│'
  let g:indentLine_first_char = '│'
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_setColors = 0
endif

if exists("g:neovide")
  let g:neovide_input_use_logo = 1

  map <D-v> "+p<CR>
  map! <D-v> <C-R>+
  tmap <D-v> <C-R>+
  vmap <D-c> "+y<CR> 
endif
