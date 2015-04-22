DOTFILES='~/.dotfiles'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE='true'

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS='true'

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE='true'

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS='true'

###

# Correct spelling for commands
setopt correct

# Disable correctall for filenames
unsetopt correctall

###

# Configure PATH
if [[ -r "${DOTFILES}/path" ]]; then
  source "${DOTFILES}/path"
fi

# Add SSH keys here?

# Configure zgen
if [[ -f ~/.zgen_setup ]]; then
  source ~/.zgen_setup
fi

# History options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify

setopt share_history
#setopt noclobber

setopt pushd_ignore_dups
#setopt pushd_silent

HISTSIZE=32768
SAVEHIST=${HISTSIZE}
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"


# Additional customizations

if [[ -r "${DOTFILES}/custom/exports" ]]; then
  source "${DOTFILES}/custom/exports"
fi

# Aliases that works in bash or zsh
if [[ -r "${DOTFILES}/custom/aliases" ]]; then
  source "${DOTFILES}/custom/aliases"
fi

# Functions that works in bash or zsh
if [[ -r "${DOTFILES}/custom/functions" ]]; then
  source "${DOTFILES}/custom/functions"
fi

if [[ -r "${DOTFILES}/custom/extra" ]]; then
  source "${DOTFILES}/custom/extra"
fi
