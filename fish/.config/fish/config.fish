if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

if not test -e ~/.vim/autoload/plug.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

if not contains ~/bin $PATH
  set PATH ~/bin $PATH
end

if not contains ~/.local/bin $PATH
  set PATH ~/.local/bin $PATH
end

if not contains ~/.npm-global/bin $PATH
  set PATH ~/.npm-global/bin $PATH
end

if not contains /usr/local/lib/ruby/gems/bin $PATH
  set PATH /usr/local/lib/ruby/gems/bin $PATH
end

if not contains ~/.cabal/bin $PATH
  set PATH ~/.cabal/bin $PATH
end

# GHCUP path variable
if not contains ~/.ghcup/bin $PATH
  set PATH ~/.ghcup/bin $PATH
end

if not contains ~/Code/org-seanstrom/ponyo/bin $PATH
  set PATH ~/Code/org-seanstrom/ponyo/bin $PATH
end

if not contains ~/.dotnet/tools $PATH
  set PATH ~/.dotnet/tools $PATH
end

if not contains ~/.asdf/shims $PATH
  set PATH ~/.asdf/shims $PATH
end

if not contains /usr/local/bin $PATH
  set PATH /usr/local/bin $PATH
end

# For silencing the direnv output
# set -x DIRENV_LOG_FORMAT ""

alias v="nvim"
alias vim="nvim"

# opam configuration
source /Users/seanhagstrom/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

starship init fish | source

any-nix-shell fish | source

direnv hook fish | source

source /usr/local/opt/asdf/libexec/asdf.fish

# Hide terminal title for Kitty Terminal
if set -q KITTY_WINDOW_ID
  function fish_title
    echo " "
  end
end

# if set -q NVIM_LISTEN_ADDRESS
#   alias v="edit --remote-tab"
# end

set -gx GPG_TTY (tty)

