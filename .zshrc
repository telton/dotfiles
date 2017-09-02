source ~/antigen.zsh
source ~/.zsh-nvm/zsh-nvm.plugin.zsh

antigen use oh-my-zsh

antigen bundle git 
antigen bundle nvm 
antigen bundle wd
antigen bundle tomsquest/nvm-auto-use.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# User configuration
bindkey '^ ' autosuggest-execute

antigen theme arrow
#agnoster
#PROMPT='HELLo'

# This loads nvm
export NVM_DIR="/home/telton/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  

export PROJECT_HOME=$HOME/Code/python-envs

# Source .profile so you get login configs as well
source ~/.profile
source ~/.aliases.sh

# Set the default user so the 'user@system' prompt doesn't show
export DEFAULT_USER=telton
eval $(/usr/libexec/path_helper -s)
