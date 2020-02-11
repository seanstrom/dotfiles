if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

if test -e ~/.vim/autoload/plug.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

if not contains ~/bin $PATH
  set PATH ~/bin $PATH
end

if not contains ~/.npm-global/bin $PATH
  set PATH ~/.npm-global/bin $PATH
end

# GHCUP path variable

if not contains ~/.cabal/bin $PATH
  set PATH ~/.cabal/bin $PATH
end

if not contains ~/.ghcup/bin $PATH
  set PATH ~/.ghcup/bin $PATH
end

# For silencing the direnv output
# set -x DIRENV_LOG_FORMAT ""

# For setting up fnm for detecting project node versions
# fnm env --multi | source

