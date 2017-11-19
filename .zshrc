source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle git 
antigen bundle tomsquest/nvm-auto-use.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# User configuration
bindkey '^ ' autosuggest-execute

antigen theme arrow
