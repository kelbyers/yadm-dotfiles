# only set stuff up if yadm installed and configured
if ! which yadm > /dev/null; then
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
            command yadm fetch --progress --dry-run 2> /dev/null > "$yadmdir/CHECK_LOG"
        [[ $(zstat +size "$yadmdir/CHECK_LOG") -ne 0 ]] && {
            echo "YADM:"
            cat "$yadmdir/CHECK_LOG"
        }

    ) #&
    #disown
}

(( ! ${+functions[_yadm-auto-check_zle-line-init]} )) || return 0

case "$widgets[zle-line-init]" in
# Simply define the function if zle-line-init doesn't yet exist
builtin | "") function _yadm-auto-check_zle-line-init() {
    yadm-check-all
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

zle -N zle-line-init _yadm-auto-check_zle-line-init
