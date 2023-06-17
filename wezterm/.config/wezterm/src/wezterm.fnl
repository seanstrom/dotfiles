(local wezterm (require :wezterm))

{:font_size 14.0
 :font (wezterm.font "Iosevka Term")
 :enable_tab_bar false
 :enable_scroll_bar false
 :exit_behavior "Close"
 :window_close_confirmation "NeverPrompt"
 :window_padding {:left 30
                  :right 25
                  :top 15
                  :bottom 15}
 :enable_csi_u_key_encoding true
 :adjust_window_size_when_changing_font_size false
 :color_scheme "Gruvbox dark, pale (base16)"}
