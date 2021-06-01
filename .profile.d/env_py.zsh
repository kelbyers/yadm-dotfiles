# spaceship prompt handles pyenv virtualenv prompts
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT=/usr/local/var/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null; then
    eval "$(pyenv init --path)" # this only sets up the path stuff
    eval "$(pyenv init -)"      # this makes pyenv work in the shell
    alias pyenv='nocorrect pyenv'
fi
if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init - zsh)"
fi
