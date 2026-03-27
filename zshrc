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

  local repo branch upstream counts local_only upstream_only default_ref default_branch
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

    branch=$(git -C "$repo" symbolic-ref --quiet --short HEAD 2>/dev/null) || {
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} (detached HEAD)${CAIOFBPA_COLOR_RESET}"
      continue
    }

    default_ref=$(git -C "$repo" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
    if [[ -z "$default_ref" ]]; then
      default_ref=$(git -C "$repo" for-each-ref --count=1 --format='%(refname:short)' 'refs/remotes/*/HEAD' 2>/dev/null)
    fi
    default_branch=${default_ref#*/}
    if [[ -n "$default_branch" && "$branch" != "$default_branch" ]]; then
      print -r -- "${CAIOFBPA_COLOR_WARNING}${repo} ($branch is not the default branch: $default_branch)${CAIOFBPA_COLOR_RESET}"
      continue
    fi

    if [[ -n "$(git -C "$repo" status --porcelain --untracked-files=normal 2>/dev/null)" ]]; then
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} (dirty)${CAIOFBPA_COLOR_RESET}"
      continue
    fi

    upstream=$(git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null) || {
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} (no upstream for $branch)${CAIOFBPA_COLOR_RESET}"
      continue
    }

    counts=$(git -C "$repo" rev-list --left-right --count HEAD..."$upstream" 2>/dev/null) || {
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} (unable to compare $branch and $upstream)${CAIOFBPA_COLOR_RESET}"
      continue
    }

    local_only=${counts%%[[:space:]]*}
    upstream_only=${counts##*[[:space:]]}

    if [[ "$local_only" != "0" && "$upstream_only" != "0" ]]; then
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} ($branch has diverged from $upstream)${CAIOFBPA_COLOR_RESET}"
      continue
    fi

    if [[ "$local_only" != "0" ]]; then
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} ($branch is ahead of $upstream)${CAIOFBPA_COLOR_RESET}"
      continue
    fi

    if [[ "$upstream_only" == "0" ]]; then
      print -r -- "${CAIOFBPA_COLOR_SUCCESS}${repo} (already up to date)${CAIOFBPA_COLOR_RESET}"
      continue
    fi

    print -r -- "${repo} (fast-forwarding $branch <- $upstream)"
    if ! git -C "$repo" merge --ff-only "$upstream" >/dev/null 2>&1; then
      print -r -- "${CAIOFBPA_COLOR_ERROR}${repo} (failed to fast-forward $branch <- $upstream)${CAIOFBPA_COLOR_RESET}"
    fi
  done
}

alias fresh='fresh_repos'

# opencode
export PATH=/Users/caiofbertoldi/.opencode/bin:$PATH
