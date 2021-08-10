if (has('gvim'))
  set guifont=Iosevka:h16
endif


if (has('gui_macvim') || has('gui_running'))
  set guifont=Iosevka Term:h16
  set guicursor+=a:blinkon0

  " https://github.com/ayu-theme/ayu-vim
  " let g:indentLine_char = '|'
  " let g:indentLine_first_char = '|'

  let g:indentLine_char = '│'
  let g:indentLine_first_char = '│'
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_setColors = 0
endif
