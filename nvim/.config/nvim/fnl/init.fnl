(fn setup-autocomplete []
  (local cmp (require :cmp))
  (set vim.opt.completeopt ["menu"
                            "menuone"
                            "noselect"])

  (cmp.setup.cmdline ":" {:sources [{:name "cmdline"}]})

  (cmp.setup.cmdline "/" {:sources [{:name "buffer"}]})

  (cmp.setup 
    {:sources [{:name "nvim_lsp"}
               {:name "buffer"}
               {:name "path"}
               {:name "conjure"}]
     :mapping (cmp.mapping.preset.insert
                {"<C-n>" (cmp.mapping (cmp.mapping.select_next_item) 
                                        ["i" "c"])
                 "<C-p>" (cmp.mapping (cmp.mapping.select_prev_item)
                                        ["i" "c"])
                 "<C-b>" (cmp.mapping.scroll_docs -4)
                 "<C-f>" (cmp.mapping.scroll_docs 4)
                 "<C-Space>" (cmp.mapping.complete)
                 "<C-e>" (cmp.mapping.abort)
                 "<CR>" (cmp.mapping.confirm {:select true})})}))

(fn setup-vscode-keybindings []
  (vim.keymap.set "n" "u" "<Cmd>call VSCodeNotify('undo')<CR>")
  (vim.keymap.set "n" "<C-r>" "<Cmd>call VSCodeNotify('redo')<CR>")

  (set vim.g.mapleader " ")
  (set vim.g.maplocalleader " ")

  (vim.keymap.set "n" "<leader>ee" "<Cmd>call VSCodeNotify('calva.evaluateSelection')<CR>")
  (vim.keymap.set "n" "<leader>e<esc>" "<Cmd>call VSCodeNotify('calva.clearInlineResults')<CR>")
  (vim.keymap.set "n" "<leader>ef" "<Cmd>call VSCodeNotify('calva.loadFile')<CR>"))

(fn setup-treesitter []
  (local tree-sitter (require :nvim-treesitter.configs))
  (tree-sitter.setup 
    {:indent {:enable true}
     :matchup {:enable true}
     :highlight {:enable true
                :additional_vim_regex_highlighting ["clojure"]}
     :ensure_installed ["javascript"
                        "typescript"
                        "elm"
                        "gren"
                        "clojure"
                        "nim"
                        "lua"
                        "fennel"
                        "python"
                        "c_sharp"
                        "rust"
                        "cpp"
                        "html"
                        "css"
                        "zig"
                        "comment"
                        "haskell"
                        "nix"
                        "markdown"
                        "sql"
                        "go"
                        "gitattributes"
                        "bash"
                        "gitignore"
                        "git_config"
                        "yaml"
                        "roc"
                        "dockerfile"]}))

(fn setup-lsp-servers []
  (local cmp-lsp (require :cmp_nvim_lsp))
  (local capabilities (cmp-lsp.default_capabilities))
  (local nvim-lsp (require :lspconfig))
  (local nvim-format (require :lsp-format))

  (nvim-format.setup {})
  (nvim-lsp.fsautocomplete.setup 
    {:capabilities capabilities
     :cmd ["dotnet" "fsautocomplete" "--background-service-enabled"]})
  (nvim-lsp.zls.setup
    {:capabilities capabilities})
  (nvim-lsp.clangd.setup
    {:capabilities capabilities
     :cmd ["clangd" "--compile-commands-dir=./"]})
  (nvim-lsp.clojure_lsp.setup
    {:capabilities capabilities
     :on_attach nvim-format.on_attach})
  (nvim-lsp.biome.setup
    {:capabilities capabilities
     :on_attach nvim-format.on_attach})
  (nvim-lsp.hls.setup
    {:filetypes ["haskell" "lhashell" "cabal"]})
  (nvim-lsp.marksman.setup {})
  (nvim-lsp.elmls.setup
    {:capabilities capabilities
     :on_attach nvim-format.on_attach}))

(fn setup-themes []
  (local catppuccin (require :catppuccin))
  (catppuccin.setup
   {:color_overrides {:all {}
                      :latte {:base "#B8BF97"
                            ; :base "#E3DDBC"
                            ; :base "#BFCFC4"
                            ; :base "#A2ABB8"
                              :text "#1F1F1F"}}}))

(fn setup-vscode []
  (setup-vscode-keybindings))

(fn setup-neovim []
  (local gitsigns (require :gitsigns))
  (gitsigns.setup)
  (setup-autocomplete)
  (setup-lsp-servers)
  (setup-treesitter)
  (setup-themes)

  (set vim.opt.laststatus 3)
  (require :status-line))

(if (. vim.g :vscode)
  (setup-vscode)
  (setup-neovim))
