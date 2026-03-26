# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="caiofbpa"
plugins=(docker kubectl)
source $ZSH/oh-my-zsh.sh

# PATH
eval $(/usr/libexec/path_helper -s)

# brew
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(brew shellenv)"

# utils
source $HOMEBREW_PREFIX/etc/profile.d/autojump.sh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)

# Node
eval "$(nodenv init -)"

# Python
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# dotnet
export PATH="$PATH:$HOME/.dotnet/tools"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# git
fresh_repos() {
  emulate -L zsh

  local repo branch upstream counts local_only upstream_only
  local -a repos

  repos=(./*(/N) ./*/*(/N))

  if (( ${#repos[@]} == 0 )); then
    echo "No git repositories found under $PWD"
    return 0
  fi

  for repo in "${repos[@]}"; do
    if ! git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      continue
    fi

    if [[ -n "$(git -C "$repo" status --porcelain --untracked-files=normal 2>/dev/null)" ]]; then
      echo "Skipping $repo (dirty)"
      continue
    fi

    branch=$(git -C "$repo" symbolic-ref --quiet --short HEAD 2>/dev/null) || {
      echo "Skipping $repo (detached HEAD)"
      continue
    }

    upstream=$(git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null) || {
      echo "Skipping $repo (no upstream for $branch)"
      continue
    }

    counts=$(git -C "$repo" rev-list --left-right --count HEAD..."$upstream" 2>/dev/null) || {
      echo "Skipping $repo (unable to compare $branch and $upstream)"
      continue
    }

    local_only=${counts%%[[:space:]]*}
    upstream_only=${counts##*[[:space:]]}

    if [[ "$local_only" != "0" && "$upstream_only" != "0" ]]; then
      echo "Skipping $repo ($branch has diverged from $upstream)"
      continue
    fi

    if [[ "$local_only" != "0" ]]; then
      echo "Skipping $repo ($branch is ahead of $upstream)"
      continue
    fi

    if [[ "$upstream_only" == "0" ]]; then
      echo "Skipping $repo (already up to date)"
      continue
    fi

    echo "Fast-forwarding $repo ($branch <- $upstream)"
    git -C "$repo" merge --ff-only "$upstream"
  done
}

alias fresh='fresh_repos'

# opencode
export PATH=/Users/caiofbertoldi/.opencode/bin:$PATH
