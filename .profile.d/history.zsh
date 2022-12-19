: ${HISTFILE_BACKUP:=${HISTFILE}.backup}
export HISTFILE_BACKUP

function _CMD { /bin/cp -fa ${HISTFILE} ${HISTFILE_BACKUP} }

if [[ -f ${HISTFILE_BACKUP} ]]; then
        _TS=$(zstat +mtime ${HISTFILE_BACKUP})
        if ((${_TS} < $(/bin/date -v -1d +%s))); then
            _A=$(zstat +size ${HISTFILE})
            _B=$(zstat +size ${HISTFILE_BACKUP})

            if (( (_A < _B) && ((_B * 100 / _A) > 120) )); then
                cat >&2 << EOF
!!! WARNING !!!
zsh history file seems corrupted!
EOF
            /bin/ls -l ${HISTFILE} ${HISTFILE_BACKUP}
        else
            _CMD
        fi
        unset _TS
    fi
else
    _CMD
fi

unset _TS _CMD _A _B
