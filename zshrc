# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="caiofbpa"
plugins=(docker kubectl)
source $ZSH/oh-my-zsh.sh

# brew
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(brew shellenv)"

# utils
source $HOMEBREW_PREFIX/etc/profile.d/autojump.sh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)

# PATH
eval $(/usr/libexec/path_helper -s)

# GitHub
export GITHUB_TOKEN=

# Node
eval "$(nodenv init -)"

# Python
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# dotnet
export PATH="$PATH:$HOME/.dotnet/tools"
export DOTNET_ROOT="/opt/homebrew/opt/dotnet@6/libexec"
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"
export NUGET_RESTORE_GITHUB_USER=caiofbpa
export NUGET_RESTORE_GITHUB_PAT=$GITHUB_TOKEN

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
