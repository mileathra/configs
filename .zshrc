export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gozilla"

plugins=(
    git
    web-search
)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:$HOME/local/scripts"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=magenta
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=white',underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green

# --- Env vars ---

export PAGER=less

# Increase history file size
export HISTFILESIZE=50000
export HISTSIZE=50000

# Useless
unset rc
unset SSH_ASKPASS

# Export bashrc.d
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# --- Path exports ---

if ! [[ "$PATH" != *"$HOME/.local/bin:$HOME/bin:"* ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

path_exports=(
	"$HOME/scripts"
	"$HOME/local/scripts"
	# Go
	"/usr/local/go/bin"
	"$HOME/go/bin"
	# Rust
	"$HOME/.cargo/bin"
)

for export in "${path_exports[@]}"; do
	if [[ -d "$export" && ":$PATH:" != *":$dir:"* ]]; then
		PATH="$PATH:$export"
	fi
done
export PATH

# --- Aliases ---

alias vim="nvim"
alias ll="ls -l --color"
alias el="eza --long --git --icons"
alias et="eza --long --git --icons --tree"

zd () {
	cd $(find . -type d 2>/dev/null | fzf)
}

# --- Zsh-stuff ---

source $ZSH/oh-my-zsh.sh

# Prompt

YB="%{$fg_bold[yellow]%}"
Y="%{$fg[yellow]%}"
CB="%{$fg_bold[cyan]%}"
BB="%{$fg_bold[blue]%}"
RESET="%{$reset_color%}"

PROMPT_CHAR="➜"
CWD="%c"
GIT_INFO='$(git_prompt_info)'

PROMPT="${YB}${PROMPT_CHAR}  ${Y}${CWD} ${CB}${GIT_INFO}${BB} % ${RESET}"

# Vi mode
bindkey -v

# Bind accepting autosuggest to Ctrl-S
bindkey '^s' autosuggest-accept
