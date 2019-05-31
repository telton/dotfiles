# Modification of wuffers.zsh-theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} x%{$fg_bold[blue]%}"

PROMPT='%{$fg_bold[green]%}%{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%} %{$(git_prompt_info)%}' 
#PROMPT='%{$(git_prompt_info)%}%{$fg_bold[green]%}%{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%} '
