(local windline (require :windline))
(local helper (require :windline.helpers))

(local vim-components (require :windline.components.vim))
(local basic-components (require :windline.components.basic))

(local lsp-components (require :windline.components.lsp))
(local git-components (require :windline.components.git))

(local icon-components (basic-components.cache_file_icon
                          {:default ""
                           :hl_colors [:black_light
                                       :white_light]}))

(local separators helper.separators)

(local state _G.WindLine.state)

(local hl-list
  {:Black [:white :black]
   :White [:black :white]
   :Inactive [:InactiveFg :InactiveBg]
   :Active [:ActiveFg :ActiveBg]})

(local basic
  {:divider [ basic-components.divider "" ]
   :space [ " " "" ]
   :bg [ " " "StatusLine" ]
   :file_name_inactive [ basic-components.full_file_name hl-list.Inactive ]
   :line_col_inactive [ basic-components.line_col hl-list.Inactive ]
   :progress_inactive [ basic-components.progress hl-list.Inactive ]
   :vi_mode {:hl_colors {:Normal [ :black :red :bold ]
                         :Insert [ :black :green :bold ]
                         :Visual [ :black :yellow :bold ]
                         :Replace [ :black :blue_light :bold ]
                         :Command [ :black :magenta :bold ]
                         :NormalBefore [ :red :black ]
                         :VisualBefore [:yellow :black]
                         :ReplaceBefore [:blue_light :black]
                         :CommandBefore [:magenta :black]
                         :NormalAfter [:white :red]
                         :InsertAfter [:white :green]
                         :VisualAfter [:white :yellow]
                         :ReplaceAfter [:white :blue_light]
                         :CommandAfter [:white :magenta]}
             :text (fn []
                     [[ separators.left_rounded_thin [:black_light :black_light] ]
                      [ (.. " " (. state.mode 1) " ") (. state.mode 2) ]])}
   :lsp_diagnosis {:width 90
                   :hl_colors {:red [ :red :black ]
                               :yellow [ :yellow :black ]
                               :blue [ :blue :black ]}
                   :text (fn [bufnr]
                           (if (lsp-components.check_lsp bufnr)
                             [[ (lsp-components.lsp_error {:format "  %s"}) :red ]
                              [ (lsp-components.lsp_warning {:format "  %s"}) :yellow ]
                              [ (lsp-components.lsp_hint {:format "  %s"}) :blue ]]
                             ""))}
   :file {:hl_colors {:default [ :white :black_light ]
                      :text [ :black :white_light ]}
          :text (fn [bufnr]
                  [[ " " :text]
                   (icon-components bufnr)
                   [ " " :text ]
                   [ (basic-components.cache_file_name "[No Name]" "") :text]
                   [ (basic-components.file_modified "  ") :text ]
                   [ (basic-components.cache_file_size) :text ]
                   [ " " :text ]])}
   :right {:hl_colors {:sep_before [ :black_light :white_light ]
                       :sep_after [ :black_light :black_light ]
                       :text [ :black :white_light ]}
           :text (fn []
                   [[ basic-components.line_col_lua :text ]
                    [ separators.right_rounded_thin :sep_after ]])}
   :git {:width 90
         :hl_colors {:green [ :green :black ]
                     :red [ :red :black ]
                     :blue [ :blue :black ]}
         :text (fn []
                 [[ separators.left_rounded_thin :sep_before ]
                  [ " " :default ]
                  [ separators.right_rounded_thin :sep_before ]])}})

(fn search-count []
  (let [formatter (vim-components.search_count)]
    (fn []
      (let [result (formatter)]
        (if (= result "")
          " "
          result)))))

(local default
  {:filetypes [ :default ]
   :active [basic.logo
            basic.file
            [ (search-count) [:red :black_light] ]
            [ " " [ :black :black ] ]
            basic.lsp_diagnosis
            basic.git
            basic.divider
            [ (git-components.git_branch {:icon "  "}) [ :green :black ] 90 ]
            [ " " hl-list.Black ]
            basic.vi_mode
            basic.right]
   :inactive []})

(local quickfix
  {:filetypes [ :qf :Trouble ]
   :active [[ :Quickfix [ :white :black ] ]
            [ helper.separators.slant_right [ :black :black_light ] ]
            [ (fn [] (. (vim.fn.getqflist {:title 0} :title))) ]
            [ " Total : %L " [:cyan :black_light]]
            [ helper.separators.slant_right [ :black_light :InactiveBg ] ]
            [ " " [:InactiveFg :InactiveBg] ]
            basic.divider
            [ helper.separators.slant_right [ :InactiveBg :black ] ]
            [ " " [:white :black] ]]
   :always_active true
   :show_last_status true})

(local minimap
  {:filetypes [:minimap]
   :active []
   :inactive []
   :always_active true
   :show_last_status true})

(local explorer
  {:filetypes [:fern :NvimTree :netrw]
   :active [[ " " [ :white :black ] ]]
   :always_active true
   :show_last_status true
   :floatline_show_float false
   :floatline_show_both false})

(windline.setup
  {:colors_name (fn [colors] colors)
   :statuslines [default
                 ;; quickfix
                 ;; explorer
                 minimap]})

(local lualine-utils (require :lualine.utils.utils))
(local bg-color (lualine-utils.extract_highlight_colors :Normal :bg))

(vim.cmd (.. "hi VertSplit guifg=" bg-color))
(vim.cmd (.. "hi StatusLine gui=NONE guibg=" bg-color " guifg=" bg-color))
(vim.cmd (.. "hi StatusLineNC gui=reverse guibg=" bg-color " guifg=" bg-color))

(fn hide-statusline []
  (let [api vim.api
        buftype (api.nvim_buf_get_option "%" :ft)]
    (if (= buftype "minimap")
      (api.nvim_set_option "laststatus" 0)
      (api.nvim_set_option "laststatus" 2))))

{:hide_statusline hide-statusline}
