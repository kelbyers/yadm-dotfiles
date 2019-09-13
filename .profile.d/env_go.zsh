if which goenv >/dev/null; then
    eval "$(goenv init -)"
    alias goenv="nocorrect goenv"
fi
