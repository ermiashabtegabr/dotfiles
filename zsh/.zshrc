if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/ermiashabtegabr/.oh-my-zsh"

autoload -Uz compinit
compinit -D $ZDOTDIR/.dumpfile

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER="ermiashabtegabr"

plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $ZDOTDIR/aliases --source_only
source $ZDOTDIR/paths --source_only
source $ZDOTDIR/conda --source_only
source $ZDOTDIR/functions --source_only


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/Users/ermiashabtegabr/.ghcup/env" ] && source "/Users/ermiashabtegabr/.ghcup/env" # ghcup-env
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

runscheme () {
    scheme --quiet < "$1"
}

cpnf () {
	touch "$2"
	cp "$1" "$2"
}
