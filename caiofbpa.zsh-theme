typeset -g CAIOFBPA_COLOR_SUCCESS="${fg[green]}"
typeset -g CAIOFBPA_COLOR_WARNING="${fg[yellow]}"
typeset -g CAIOFBPA_COLOR_ERROR="${fg[red]}"
typeset -g CAIOFBPA_COLOR_RESET="${reset_color}"

PROMPT='$(git_prompt_info)%{${CAIOFBPA_COLOR_WARNING}%}\$%{${CAIOFBPA_COLOR_RESET}%} '

ZSH_THEME_GIT_PROMPT_DIRTY="%{${CAIOFBPA_COLOR_ERROR}%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{${CAIOFBPA_COLOR_SUCCESS}%}"

function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)${ref#refs/heads/}%{${CAIOFBPA_COLOR_RESET}%} "
}
