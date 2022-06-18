local mod = {}

local windline = require('windline')
local helper = require('windline.helpers')
local sep = helper.separators
local vim_components = require('windline.components.vim')

local b_components = require('windline.components.basic')
local state = _G.WindLine.state

local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')

local hl_list = {
    Black = { 'white', 'black' },
    White = { 'black', 'white' },
    Inactive = { 'InactiveFg', 'InactiveBg' },
    Active = { 'ActiveFg', 'ActiveBg' },
}
local basic = {}

basic.divider = { b_components.divider, '' }
basic.space = { ' ', '' }
basic.bg = { ' ', 'StatusLine' }
basic.file_name_inactive = { b_components.full_file_name, hl_list.Inactive }
basic.line_col_inactive = { b_components.line_col, hl_list.Inactive }
basic.progress_inactive = { b_components.progress, hl_list.Inactive }

basic.vi_mode = {
    hl_colors = {
        Normal = { 'black', 'red', 'bold' },
        Insert = { 'black', 'green', 'bold' },
        Visual = { 'black', 'yellow', 'bold' },
        Replace = { 'black', 'blue_light', 'bold' },
        Command = { 'black', 'magenta', 'bold' },
        NormalBefore = { 'red', 'black' },
        InsertBefore = { 'green', 'black' },
        VisualBefore = { 'yellow', 'black' },
        ReplaceBefore = { 'blue_light', 'black' },
        CommandBefore = { 'magenta', 'black' },
        NormalAfter = { 'white', 'red' },
        InsertAfter = { 'white', 'green' },
        VisualAfter = { 'white', 'yellow' },
        ReplaceAfter = { 'white', 'blue_light' },
        CommandAfter = { 'white', 'magenta' },
    },
    text = function()
        return {
            { sep.left_rounded, state.mode[2] .. 'Before' },
            { state.mode[1] .. ' ', state.mode[2] },
        }
    end,
}

basic.lsp_diagnos = {
    width = 90,
    hl_colors = {
        red = { 'red', 'black' },
        yellow = { 'yellow', 'black' },
        blue = { 'blue', 'black' },
    },
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                { lsp_comps.lsp_error({ format = '  %s' }), 'red' },
                { lsp_comps.lsp_warning({ format = '  %s' }), 'yellow' },
                { lsp_comps.lsp_hint({ format = '  %s' }), 'blue' },
            }
        end
        return ''
    end,
}


local icon_comp = b_components.cache_file_icon({ default = '', hl_colors = {'white_light','black_light'} })

basic.file = {
    hl_colors = {
        default = { 'white', 'black_light' },
        text = { 'white_light', 'black_light' },
    },
    text = function(bufnr)
        return {
            { ' ', 'default' },
            icon_comp(bufnr),
            { ' ', 'default' },
            { b_components.cache_file_name('[No Name]', ''), 'text' },
            { b_components.file_modified(' '), 'text' },
            { b_components.cache_file_size(), 'text' },
        }
    end,
}
basic.right = {
    hl_colors = {
        sep_before = { 'black_light', 'white_light' },
        sep_after = { 'white_light', 'black' },
        text = { 'black', 'white_light' },
    },
    text = function()
        return {
            { b_components.line_col_lua, 'text' },
            { sep.right_rounded, 'sep_after' },
        }
    end,
}
basic.git = {
    width = 90,
    hl_colors = {
        green = { 'green', 'black' },
        red = { 'red', 'black' },
        blue = { 'blue', 'black' },
    },
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                { ' ', '' },
                { git_comps.diff_added({ format = ' %s' }), 'green' },
                { git_comps.diff_removed({ format = '  %s' }), 'red' },
                { git_comps.diff_changed({ format = ' 柳%s' }), 'blue' },
            }
        end
        return ''
    end,
}
basic.logo = {
    hl_colors = {
        sep_before = { 'blue', 'black' },
        default = { 'black', 'blue' },
    },
    text = function()
        return {
            { sep.left_rounded, 'sep_before' },
            { ' ', 'default' },
        }
    end,
}

local default = {
    filetypes = { 'default' },
    active = {
        -- { ' ', { 'black', 'black' } },
        basic.logo,
        basic.file,
        { vim_components.search_count(), { 'red', 'black_light' } },
        { sep.right_rounded, { 'black_light', 'black' } },
        basic.lsp_diagnos,
        basic.git,
        basic.divider,
        { git_comps.git_branch({ icon = '  ' }), { 'green', 'black' }, 90 },
        { ' ', hl_list.Black },
        basic.vi_mode,
        basic.right,
        -- { ' ', hl_list.Black },
    },
    inactive = {
        -- basic.file_name_inactive,
        -- basic.divider,
        -- basic.divider,
        -- basic.line_col_inactive,
        -- { '', { 'black', 'InactiveBg' } },
        -- basic.progress_inactive,
    },
}

local quickfix = {
    filetypes = { 'qf', 'Trouble' },
    active = {
        { '🚦 Quickfix ', { 'white', 'black' } },
        { helper.separators.slant_right, { 'black', 'black_light' } },
        {
            function()
                return vim.fn.getqflist({ title = 0 }).title
            end,
            { 'cyan', 'black_light' },
        },
        { ' Total : %L ', { 'cyan', 'black_light' } },
        { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
        { ' ', { 'InactiveFg', 'InactiveBg' } },
        basic.divider,
        { helper.separators.slant_right, { 'InactiveBg', 'black' } },
        { '🧛 ', { 'white', 'black' } },
    },
    always_active = true,
    show_last_status = true
}

local minimap = {
    filetypes = { 'minimap' },
    active = {},
    inactive = {},
    always_active = true,
    show_last_status = true,
}

local explorer = {
    filetypes = {'fern', 'NvimTree','netrw'},
    active = {
        {'  ', {'white', 'black'} },
    },
    --- show active components when the window is inactive
    always_active = true,
    --- It will display a last window statusline even that window should inactive
    show_last_status = true,

    -- setting for floatline
    -- display statusline to that filetype.If that filetype on floating window
    floatline_show_float = false,
    -- display both on floatline and default statusline
    floatline_show_both = false
}

windline.setup({
    colors_name = function(colors)
        -- ADD MORE COLOR HERE ----
        return colors
    end,
    statuslines = {
        default,
        --quickfix,
        --explorer,
        minimap
    },
})

local bg_color = require('lualine.utils.utils').extract_highlight_colors('Normal', 'bg')
vim.cmd("hi VertSplit guifg=" .. bg_color)
vim.cmd("hi StatusLine gui=NONE guibg=" .. bg_color .. " guifg=" .. bg_color)
vim.cmd("hi StatusLineNC gui=reverse guibg=" .. bg_color .. " guifg=" .. bg_color)

mod.hide_statusline = function()
   local api = vim.api
   local buftype = api.nvim_buf_get_option("%", "ft")

   if buftype == "minimap" then
      api.nvim_set_option("laststatus", 0)
      return
   else
      api.nvim_set_option("laststatus", 2)
   end
end

return mod
