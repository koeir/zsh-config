eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

export PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ZSH_THEME="steeef"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf-tab zsh-fzf-history-search paccheck cli-functions reminders)

source $ZSH/oh-my-zsh.sh

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Login stdout
## Checks for any failed services
# systemctl --failed --no-pager

## Tells battery life
# echo ""
# acpi -b

# bashtools
bashtools="/usr/share/bashtools"
if [ -d "$bashtools" ]; then
    pathadd append "$bashtools"
fi
