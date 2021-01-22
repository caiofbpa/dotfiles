export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="caiofbpa"

plugins=(autojump docker kubectl)

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/sbin"

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

fpath=(/usr/local/share/zsh-completions $fpath)
eval $(/usr/libexec/path_helper -s)
eval "$(pyenv init -)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"

export GOOGLE_USERNAME=caio@mercos.com
export GOOGLE_SP_ID=139191105735
export GOOGLE_IDP_ID=C01tez3v6
export AWS_PROFILE=default

export PYTHONDONTWRITEBYTECODE=1

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
