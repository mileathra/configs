export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gozilla"

plugins=(
    web-search
)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:$HOME/local/scripts"

# C_PROMPT_CHAR=yellow   # bold
# C_CWD=yellow
# C_GIT=cyan             # bold
# C_TAIL=blue            # bold
# C_SUFFIX_ALIAS=white
# C_PRECOMMAND=magenta
# C_UNKNOWN=white
# C_ARG0=green

# --- Tokyo Night ---
C_PROMPT_CHAR='#e0af68'  # yellow
C_CWD='#e0af68'          # yellow
C_GIT='#7dcfff'          # cyan
C_TAIL='#7aa2f7'         # blue
C_SUFFIX_ALIAS='#c0caf5' # fg
C_PRECOMMAND='#bb9af7'   # magenta
C_UNKNOWN='#c0caf5'      # fg
C_ARG0='#9ece6a'         # green

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=${C_SUFFIX_ALIAS},underline"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=${C_PRECOMMAND}"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${C_UNKNOWN},underline"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=${C_ARG0}"

# --- Env vars ---

export PAGER=less
export EDITOR=nvim

# Increase history file size
export HISTFILESIZE=50000
export HISTSIZE=50000

export FJ_FALLBACK_HOST=https://codeberg.org/

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

alias k="kubectl"
alias vim="nvim"
alias ll="ls -l --color"
alias el="eza --long --git --icons"
alias et="eza --long --git --icons --tree"
alias g="nav g"

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
PROMPT="%B%F{${C_PROMPT_CHAR}}${PROMPT_CHAR}  %F{${C_CWD}}${CWD} %F{${C_GIT}}${GIT_INFO} %b%f"

# Vi mode
bindkey -v
bindkey '^?' backward-delete-char

# Bind accepting autosuggest to Ctrl-S
bindkey '^s' autosuggest-accept
bindkey '^F' autosuggest-accept
# nav shell integration
export PATH="${HOME}/.local/bin:${PATH}"
fpath=("${HOME}/.local/share/zsh/site-functions" $fpath)
autoload -Uz compinit && compinit

nav() {
    if [[ "$1" == "go" || "$1" == "g" ]]; then
        local dest
        dest=$(command nav expand "${@:2}") && cd "$dest"
    else
        command nav "$@"
    fi
}

# li shell integration
export PATH="${HOME}/.local/bin:${PATH}"
fpath=("${HOME}/.local/share/zsh/site-functions" $fpath)
autoload -Uz compinit && compinit

export YW_PARSER_PATH="${HOME}/dev/rust/yaw/tree-sitter-yaw"
