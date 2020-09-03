if which goenv >/dev/null; then
    export GOENV_ROOT=/usr/local/var/goenv
    eval "$(goenv init -)"
    alias goenv="nocorrect goenv"
fi
