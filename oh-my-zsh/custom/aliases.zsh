# Aliases
alias ls='ls --color'
alias eza='eza -T'
alias lla='ls -la --color'
alias x8='exit'
alias cbs='acpi -b'
alias vim='nvim'
alias f2b='sudo fail2ban-client'
alias fcd='cd "$(find . -type d | fzf)"'
alias so='source $HOME/.zshrc'
alias grepv='grep -v grep | grep'

# git aliases
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"

# pacman aliases
alias pacin='sudo pacman -S --needed'
alias pacref='sudo pacman -Sy'
alias pacsearch='pacman -Ss'
alias pacinfo='pacman -Si'
alias pacupg='sudo pacman -Syu'
alias pacrem='sudo pacman -Ru'
alias pacquery='pacman -Q'
alias pacqinfo='pacman -Qi'

# systemctl aliases
alias systatus='systemctl status --no-pager'
alias systart='sudo systemctl start'
alias systop='sudo systemctl stop'
alias sysenable='sudo systemctl enable'
alias sysdisable='sudo systemctl disable'
alias sysrestart='sudo systemctl restart'
alias sysreload='sudo systemctl reload'
alias sysuser='sudo systemctl --user'
alias sysdreload='sudo systemctl daemon-reload'
alias sysedit='sudo systemctl edit'
alias reboot='sudo systemctl reboot'

# Environment Variables
export systemd='/etc/systemd/system'
