(local wezterm (require :wezterm))

{:font_size 16.0
 :font (wezterm.font "Iosevka Nerd Font Mono")
 :enable_tab_bar false
 :enable_scroll_bar false
 :exit_behavior "Close"
 :window_close_confirmation "NeverPrompt"
 :window_decorations "INTEGRATED_BUTTONS|RESIZE"
 :window_padding {:left 30
                  :right 20
                  :top 60
                  :bottom 15}
 :enable_csi_u_key_encoding true
 :adjust_window_size_when_changing_font_size false
;  :color_scheme "Gruvbox light, medium (base16)"
;  :color_scheme "Gruvbox dark, soft (base16)"
 :color_scheme "Gruvbox dark, hard (base16)"
 :keys [{:key "s"
         :mods "SUPER"
         :action (wezterm.action.SendKey {:key "s"
                                          :mods "CTRL"})}]}
