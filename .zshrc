# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jxb2016/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
# ZSH_THEME="bullet-train"
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv pyenv go_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PYENV_BACKGROUND='235'
POWERLEVEL9K_PYENV_FOREGROUND='159'
POWERLEVEL9K_GO_VERSION_BACKGROUND='235'
POWERLEVEL9K_GO_VERSION_FOREGROUND='209'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git \
        colored-man-pages \
        common-aliases \
        dircycle \
        dirpersist \
        last-working-dir \
        z \
        sudo \
        wd \
        gitignore \
        vagrant \
        pip \
        python \
        # pyenv \ ### DO NOT USE pyenv PLUGIN!!! Breaks pyenv!!!
        bundler \
        # virtualenv \
        #virtualenvwrapper \
        brew \
        osx \
        cf \
        golang \
        helm \
        kubectl \
        kube-ps1 \
        )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
EDITOR=code

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# enable extended glob search features. This allows things like:
# print -l (^vendor/)#
# which finds all items in subdirectories except for the `vendor/` directory
setopt EXTENDED_GLOB

alias tox='nocorrect tox'
alias pdk='nocorrect pdk'

# load location aliases
[[ -r $HOME/.profile.d/location_aliases_current.zsh ]] && source $HOME/.profile.d/location_aliases_current.zsh

#BULLETTRAIN_PROMPT_ORDER=( time status custom context dir perl ruby virtualenv nvm go elixir git hg cmd_exec_time )
BULLETTRAIN_PROMPT_ORDER=( time status custom dir go ruby virtualenv git cmd_exec_time )
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
# BULLETTRAIN_DIR_EXTENDED=0

# Bullettrain handles the virtualenv prompt for us
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT=/usr/local/var/pyenv

export GIT_PAGER="less -RFX"

if which pyenv > /dev/null; then eval "$(pyenv init - zsh)"; alias pyenv='nocorrect pyenv'; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init - zsh)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; alias rbenv='nocorrect rbenv'; fi
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# postgresql
export PGDATABASE=postgres

function k_prompt { PROMPT='$(kube_ps1)'$PROMPT; }
__KUBECONFIGS=( $HOME/.kube/config $(print $HOME/.kube/*.config) )
if (( ${#__KUBECONFIGS} > 0 )); then 
    export KUBECONFIG=${(j/:/)__KUBECONFIGS}
fi
unset __KUBECONFIGS
source /Users/jxb2016/google-cloud-sdk/path.zsh.inc
source /Users/jxb2016/google-cloud-sdk/completion.zsh.inc

# Pimssh
alias pimpr="pimssh -p -A"
alias pimnp="pimssh -n"

eval "$(direnv hook zsh)"

#### USE DIRENV
## ADD THESE TO YOUR .envrc FILE
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/jxb2016/.sdkman"
# [[ -s "/Users/jxb2016/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jxb2016/.sdkman/bin/sdkman-init.sh"
