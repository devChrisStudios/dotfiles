# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Plugins ---
source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# zsh-completions — must be added to fpath before compinit
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
# zsh-syntax-highlighting must be sourced LAST
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Completions ---
autoload -Uz compinit && compinit

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
alias cd='z'
alias cl='clear'
alias mux='~/bin/tmux-start.sh'
alias rrun='cargo run --quiet'

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

# --- Shell integrations ---
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
export MANPAGER='nvim +Man!'

# Created by `pipx` on 2026-02-26 04:16:21
export PATH="$PATH:/home/loki/.local/bin"
