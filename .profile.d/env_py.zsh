# spaceship prompt handles pyenv virtualenv prompts
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT=/usr/local/var/pyenv

if which pyenv >/dev/null; then
    eval "$(pyenv init - zsh)"
    alias pyenv='nocorrect pyenv'
fi
if which pyenv-virtualenv-init >/dev/null; then
    eval "$(pyenv virtualenv-init - zsh)"
fi
