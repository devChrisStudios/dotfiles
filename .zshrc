# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to story zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# --- Powerlevel10k ---
zinit ice depth=1; zinit light romkatv/powerlevel10k

# --- Plugins ---
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# --- Snippets ---
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# --- Completions ---
autoload -Uz compinit && compinit

zinit cdreplay -q

# --- Powerlevel10k config ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# --- Keybindings ---
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word

# --- History ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# --- Completion styling ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# --- Aliases ---
alias ls='exa -a'
alias ll='exa -alh'
alias tree='exa --tree'
alias grep='rg --color=auto'
alias vim='nvim'
alias inv='nvim $(fzf --preview="bat --color=always {}")'
alias cl='clear'
alias mux='~/bin/tmux-start.sh'
alias rrun='cargo run --quiet'


# --- Shell integrations ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# --- Starship ---
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Set nvim as our manpager
export MANPAGER='nvim +Man!'

# fpath=(~/.zsh/plugins/zsh-completions/src $fpath)
fpath=($HOME/.zsh_completions $fpath)

# Created by `pipx` on 2026-02-26 04:16:21
export PATH="$PATH:/home/loki/.local/bin"
# opencode
export PATH=/home/loki/.opencode/bin:$PATH

# Tmux Script Completion
_tmux_start_completion() {
	local -a projects
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		'1:language:(rust js python)' \
		'2:project:->projects'

	case $state in
		projects)
			case ${words[2]} in
				rust) projects=(${(f)"$(ls -1 ~/projects/rust 2>/dev/null)"}) ;;
				js)   projects=(${(f)"$(ls -1 ~/projects/js 2>/dev/null)"}) ;;
				python)   projects=(${(f)"$(ls -1 ~/projects/python 2>/dev/null)"}) ;;
				*)    projects=() ;;
			esac
			_describe 'project' projects
			;;
	esac
}
compdef _tmux_start_completion tmux-start.sh

export PATH="$HOME/.npm-global/bin:$PATH"
