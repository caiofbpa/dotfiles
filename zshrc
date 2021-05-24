export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="caiofbpa"
plugins=(docker kubectl)
source $ZSH/oh-my-zsh.sh

[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

source `brew --prefix`/etc/profile.d/autojump.sh
source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source `brew --prefix`/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fpath=(`brew --prefix`/share/zsh-completions $fpath)

eval $(/usr/libexec/path_helper -s)

eval "$(nodenv init -)"
eval "$(rbenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PYTHONDONTWRITEBYTECODE=1

export GOOGLE_USERNAME=caio@mercos.com
export GOOGLE_SP_ID=139191105735
export GOOGLE_IDP_ID=C01tez3v6
export AWS_PROFILE=default
