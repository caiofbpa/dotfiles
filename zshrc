export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="caiofbpa"
plugins=(docker kubectl)
source $ZSH/oh-my-zsh.sh

[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(brew shellenv)"

source $HOMEBREW_PREFIX/etc/profile.d/autojump.sh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)

eval $(/usr/libexec/path_helper -s)

eval "$(nodenv init -)"
eval "$(rbenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PYTHONDONTWRITEBYTECODE=1

export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

export AWS_PROFILE=default
