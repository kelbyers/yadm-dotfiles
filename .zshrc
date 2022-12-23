##############################################################################
# Customizations
##############################################################################

# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"

export ZSH_CACHE_DIR="$HOME/.cache"

[[ ! -d ${ZSH_CACHE_DIR} ]] && mkdir -p ${ZSH_CACHE_DIR}

# Correct spelling for commands
setopt correct

# allow tab-completion of aliases
setopt no_complete_aliases

# turn off the infernal correctall for filenames
unsetopt correctall

# Base PATH
PATH=/usr/local/bin:/usr/local/sbin
PATH=$PATH:/sbin:/usr/sbin
PATH=$PATH:/bin:/usr/bin
PATH=$PATH:/usr/local/munki

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
# user completions
##############################################################################
fpath+=(~/.zfunc)

##############################################################################
# zgenom
##############################################################################
# ZGEN_AUTOUPDATE_VERBOSE=1   # display a handy message when autoupdate runs!
if [ -f ~/.zgenom-setup ]; then
    source ~/.zgenom-setup
fi

# enable extended glob search features. This allows things like:
# print -l (^vendor/)#
# which finds all items in subdirectories except for the `vendor/` directory
setopt EXTENDED_GLOB

export GIT_PAGER="less -RFX"

[[ -d ~/.profile.d ]] && for __E in ~/.profile.d/*.(zsh|sh); do
    source $__E
done
unset __E

test -e "${HOME}/.iterm2_shell_integration.zsh" &&
    source "${HOME}/.iterm2_shell_integration.zsh"

[[ ! -f $HOME/.zshrc.local ]] || source $HOME/.zshrc.local
