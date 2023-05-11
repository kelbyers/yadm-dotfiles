# only set stuff up if yadm installed and configured
if ! which yadm > /dev/null; then
    return 0
fi

if [[ -z $SPACESHIP_VERSION ]]; then
    return 0
fi

# Default auto-check interval: 3600 seconds
: ${YADM_AUTO_CHECK_INTERVAL:=3600}

# Necessary for the yadm-check-all function
zmodload zsh/datetime zsh/stat

function yadm-check-all {
    (
        # get yadm repo directory
        if ! yadmdir="$(yadm introspect repo 2> /dev/null)"; then
            return 0
        fi

        # Do nothing if auto-check is disabled or don't have permissions
        if [[ ! -w "$yadmdir" || -f "$yadmdir/NO_AUTO_CHECK" ]] ||
            [[ -f "$yadmdir/CHECK_LOG" && ! -w "$yadmdir/CHECK_LOG" ]]; then
            return 0
        fi

        # Get time (seconds) when auto-check was last run
        lastrun="$(zstat +mtime "$yadmdir/CHECK_LOG" 2> /dev/null || echo 0)"

        # Do nothing if not enough time has passed since last auto-check
        if ((EPOCHSECONDS - lastrun < $YADM_AUTO_CHECK_INTERVAL)); then
            return 0
        fi

        # Check all remotes (avoid ssh passphrase prompt)
        GIT_SSH_COMMAND="command ssh -o BatchMode=yes" \
            command yadm fetch --progress > "$yadmdir/CHECK_LOG" 2>&1
    ) &|
}

(( ! ${+functions[_yadm-auto-check_zle-line-init]} )) || return 0

case "$widgets[zle-line-init]" in
# Simply define the function if zle-line-init doesn't yet exist
builtin | "") function _yadm-auto-check_zle-line-init() {
    yadm-check-all⊚
} ;;
# Override the current zle-line-init widget, calling the old one
user:*)
    zle -N _yadm-auto-check_orig_zle-line-init "${widgets[zle-line-init]#user:}"
    function _yadm-auto-check_zle-line-init() {
        yadm-check-all
        zle _yadm-auto-check_orig_zle-line-init -- "$@"
    }
    ;;
esac

SPACESHIP_YADM_SHOW="${SPACESHIP_YADM_SHOW=true}"
SPACESHIP_YADM_SYMBOL="${SPACESHIP_YADM_SYMBOL=⊚}"
SPACESHIP_YADM_PREFIX="${SPACESHIP_YADM_PREFIX=yadm: }"
SPACESHIP_YADM_SUFFIX="${SPACESHIP_YADM_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX}"
SPACESHIP_YADM_COLOR="${SPACESHIP_YADM_COLOR=white}"
spaceship_yadm () {
    [[ $SPACESHIP_YADM_SHOW == false ]] && return

    # check if yadm is out of date
    [[ -z "$(yadm status --porcelain -b 2> /dev/null |
        grep -v '^## master...origin/master$')" ]] && return

    spaceship::section \
        "$SPACESHIP_YADM_COLOR" \
        "$SPACESHIP_YADM_PREFIX" \
        "$SPACESHIP_YADM_SYMBOL" \
        "$SPACESHIP_YADM_SUFFIX"
}
__YADM_GIT_ORDER=${SPACESHIP_PROMPT_ORDER[(ie)git]}
SPACESHIP_PROMPT_ORDER=( ${SPACESHIP_PROMPT_ORDER[0,$((__YADM_GIT_ORDER - 1))]}
    yadm ${SPACESHIP_PROMPT_ORDER[$__YADM_GIT_ORDER, -1]})
unset __YADM_GIT_ORDER

zle -N zle-line-init _yadm-auto-check_zle-line-init
