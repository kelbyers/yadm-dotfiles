if [[ $(command -v fzf) == */homebrew/* ]]; then
    export FZF_PATH=$(readlink -f $(command -v fzf))
    # ZSH expansions:
    # ${FZF_PATH:P}  # resolve symlinks to the actual path
    # ${FZF_PATH:h}  # remove the final path component
    # ${FZF_PATH:h:h}  # remove the final two path components
    FZF_PATH=${FZF_PATH:P:h:h}
fi

# Set up fzf key bindings and fuzzy completion
if which fzf > /dev/null; then
    eval "$(fzf --zsh)"
    export FZF_PREVIEW_ADVANCED=true
    export LESSOPEN='| lessfilter-fzf %s'
fi
