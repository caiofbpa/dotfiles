PROMPT='$(git_prompt_info)%{$fg[yellow]%}$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)${ref#refs/heads/}%{$reset_color%} "
}
