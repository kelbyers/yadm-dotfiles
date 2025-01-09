# if [[ -x /opt/homebrew/bin/brew ]]; then
#     BREW_LOCATION="/opt/homebrew/bin/brew"
# elif [[ -x /usr/local/bin/brew ]]; then
#     BREW_LOCATION="/usr/local/bin/brew"
# else
#     return
# fi

# # Only add Homebrew installation to PATH, MANPATH, and INFOPATH if brew is
# # not already on the path, to prevent duplicate entries. This aligns with
# # the behavior of the brew installer.sh post-install steps.
# eval "$("$BREW_LOCATION" shellenv)"
# unset BREW_LOCATION

if [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
        alias ibrew='arch -x86_64 /usr/local/bin/brew'
    fi
elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
