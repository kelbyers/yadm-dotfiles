if which rbenv >/dev/null; then
    eval "$(rbenv init - zsh)"
    alias rbenv='nocorrect rbenv'
fi
