vim.cmd('source ~/.config/nvim/vim/init.vim')
require('status-line')


-- local cmd = vim.cmd
-- local function fg(group, color)
--    cmd("hi " .. group .. " guifg=" .. color)
-- end

-- vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("status-line").hide_statusline() ]]
-- fg("StatusLineNC", "white gui=underline")
