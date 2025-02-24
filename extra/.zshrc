[[ $- != *i* ]] && return

# colors
autoload -U colors && colors

# prompt
setopt PROMPT_SUBST
PS1='%F{204}$(if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then echo "$(parse_git_branch) "; fi)%F{#89b4fa}%~ %F{#89b4fa}$ %f'

# essential stuff
stty -ixon # disable ctrl+s and ctrl+q
HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# essentials
alias grep='grep --color=auto'
alias ff='clear && fastfetch'
alias c='clear'
alias rm='rm -rf'
alias vim='nvim'
alias debloat='~/Documents/debloat.sh'
alias chmod='chmod +x'
alias mpv='mpv --keep-open'
alias record='mkdir -p ~/recordings && ffmpeg -f x11grab -r 60 -s 2560x1440 -i :0.0 -c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p -vf "scale=2560:1440" -threads 0 ~/recordings/$(date +"%Y-%m-%d-%H-%M-%S").mp4'
alias history='history 1'
alias ls="eza -a --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ..='cd ..'

# git based actions
alias checkout='git checkout'
alias push='git push'
alias fetch='git fetch'
alias merge='git merge'
alias add='git add .'
alias stash='git stash && git stash drop'
alias status='git status'
alias log='git log'

# env's
export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='st-256color'
export BROWSER='librewolf'

# parse the branch and transfer it to the prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# stashes changes before pulling and then releases the changes
pull() {
    git stash
    git pull
    git stash pop
}

# commit with a message dynamically
commit() {
    git add .
    git commit -m "$*"
    git push
}

# cloning and cding into that cloned repo
clone() { 
    git clone "$1" 2>/dev/null && cd "$(basename "$1" .git)"
}

# dynamically delete branches while on the branch you want to delete
branch() {
    if [ "$1" = "-d" ] && [ -n "$2" ]; then
        git checkout main 2>/dev/null || git checkout master 2>/dev/null
        git branch -d "$2"
    else
        git branch "$@"
    fi
}

# rebasing
rebase() {
    if [ "$1" = "--abort" ]; then
        git rebase --abort
        return
    fi
    if [[ "$1" =~ ^[0-9]+$ ]] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git rebase -i HEAD~"$1"
    fi
}

eval "$(zoxide init zsh --cmd cd)"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[comment]='fg=#585b70'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[function]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6e3a1,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fab387,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f38ba8'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#f38ba8'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#f38ba8'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#f38ba8'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[path]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cdd6f4,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f38ba8,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#cba6f7'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#eba0ac'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[default]='fg=#cdd6f4'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#cdd6f4'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^ ' autosuggest-accept

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi"

export PATH=~/.local/bin:$PATH

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

eval "$(oh-my-posh init zsh --config ~/catppuccin_mocha.omp.json)"

# Define colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
BLUE="\e[34m"
PASTEL_PINK="\e[38;5;218m"
MAGENTA="\e[35m"
RED="\e[31m"
RESET="\e[0m"

# Define the function `nekofetch`
nekofetch() {
  # ASCII Art in Pastel Pink
  ASCII_ART="${PASTEL_PINK}
        へ  ♡  ╱|、
     ૮ - ՛)   (\` - 7
      /⁻ ៸|   |、՛〵
  乀(ˍ,ل  ل   じしˍ,)ノ 
  ${RESET}"

  # Get terminal prompt and user information
  USER=$(whoami)
  HOST=${HOST}
  CWD=$(pwd)
  PROMPT="${GREEN}${USER}@${HOST}:${YELLOW}${CWD}${RESET}"

  # Gather system information
  OS=$(lsb_release -d | awk -F"\t" '{print $2}')
  KERNEL=$(uname -r)
  UPTIME=$(uptime -p)
  SHELL=$SHELL
  CPU=$(lscpu | grep 'Model name' | awk -F: '{print $2}' | xargs)
  MEMORY=$(free -h | grep Mem | awk '{print $3 "/" $2}')

  # Display ASCII Art
  echo -e "$ASCII_ART"

  # Display the separator line with the prompt
  echo -e "${CYAN}----------------------------------------${RESET}"
  echo -e "$PROMPT"
  echo -e "${CYAN}----------------------------------------${RESET}"

  # Display system information
  echo -e "${BLUE}Username:${RESET} ${MAGENTA}$USER${RESET}"
  echo -e "${BLUE}Operating System:${RESET} ${MAGENTA}$OS${RESET}"
  echo -e "${BLUE}Kernel Version:${RESET} ${MAGENTA}$KERNEL${RESET}"
  echo -e "${BLUE}Uptime:${RESET} ${MAGENTA}$UPTIME${RESET}"
  echo -e "${BLUE}Shell:${RESET} ${MAGENTA}$SHELL${RESET}"
  echo -e "${BLUE}CPU:${RESET} ${MAGENTA}$CPU${RESET}"
  echo -e "${BLUE}Memory Usage:${RESET} ${MAGENTA}$MEMORY${RESET}"
}
