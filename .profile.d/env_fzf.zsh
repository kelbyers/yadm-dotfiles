# Set up fzf key bindings and fuzzy completion
if which fzf > /dev/null; then
    eval "$(fzf --zsh)"
    export FZF_PREVIEW_ADVANCED=true
    export LESSOPEN='| lessfilter-fzf %s'
fi
