##############################################################################
# Customizations
##############################################################################

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

## Spaceship Prompt Customizations
export SPACESHIP_EXIT_CODE_SHOW=true
export SPACESHIP_HOST_SHOW=always

export ZSH_CACHE_DIR="$HOME/.cache"

[[ ! -d ${ZSH_CACHE_DIR} ]] && mkdir -p ${ZSH_CACHE_DIR}

# Correct spelling for commands
setopt correct

# allow tab-completion of aliases
setopt no_complete_aliases

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin

# Conditional PATH additions
for path_candidate in /opt/local/sbin \
    /Applications/Xcode.app/Contents/Developer/usr/bin \
    /opt/local/bin \
    /opt/puppetlabs/pdk/bin \
    /opt/X11/bin \
    ~/.rbenv/bin \
    ~/bin \
    ~/src/gocode/bin
do
    if [ -d ${path_candidate} ]; then
      export PATH=${PATH}:${path_candidate}
    fi
done

##############################################################################
# zgen
##############################################################################
ZGEN_AUTOUPDATE_VERBOSE=1   # display a handy message when autoupdate runs!
if [ -f ~/.zgen-setup ]; then
    source ~/.zgen-setup
fi

# enable extended glob search features. This allows things like:
# print -l (^vendor/)#
# which finds all items in subdirectories except for the `vendor/` directory
setopt EXTENDED_GLOB

alias tox='nocorrect tox'
alias pdk='nocorrect pdk'

# load location aliases
[[ -r $HOME/.profile.d/location_aliases_current.zsh ]] && source $HOME/.profile.d/location_aliases_current.zsh

export GIT_PAGER="less -RFX"
# spaceship prompt handles pyenv virtualenv prompts
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT=/usr/local/var/pyenv

if which pyenv > /dev/null; then eval "$(pyenv init - zsh)"; alias pyenv='nocorrect pyenv'; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init - zsh)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; alias rbenv='nocorrect rbenv'; fi
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# postgresql
export PGDATABASE=postgres

SPACESHIP_KUBECONTEXT_SHOW=false

function k_prompt {
    [[ $SPACESHIP_KUBECONTEXT_SHOW = true ]] &&
    SPACESHIP_KUBECONTEXT_SHOW=false ||
    SPACESHIP_KUBECONTEXT_SHOW=true
}

if [[ -d $HOME/.kube && -f $HOME/.kube/config ]]; then
    __KUBECONFIGS=( $HOME/.kube/config $(print $HOME/.kube/*.config) )
    if (( ${#__KUBECONFIGS} > 0 )); then
        export KUBECONFIG=${(j/:/)__KUBECONFIGS}
    fi
    unset __KUBECONFIGS
fi

# Pimssh
if command -v pimssh > /dev/null; then
    alias pimpr="pimssh -p -A"
    alias pimnp="pimssh -n"
fi

command -v direnv > /dev/null && eval "$(direnv hook zsh)"
