# only set stuff up if yadm installed and configured
if ! which git-town > /dev/null; then
    return 0
fi

source <(git-town completions zsh)
