if command -v cf > /dev/null 2>&1; then
    if [[ -f ~/.config/nushell/cf.nu ]]; then
        alias cf-get-configs='nu -l -c "cf get-configs"'
        alias cf-get-config='nu -l -c "cf get-config"'

        function cf-relogin() {
            nu -l -c "cf relogin $*"
        }

        function cf-rename-config() {
            nu -l -c "cf rename-config $1 $2"
        }

        function cf-copy-config() {
            nu -l -c "cf copy-config $1 $2"
        }

        function cf-delete-config() {
            nu -l -c "cf delete-config $1"
        }

        function cf-create-config() {
            nu -l -c "cf create-config $1"
        }

        function cf-set-config() {
            eval $(nu -l -c "cf export-config-zsh $1")
        }
    fi
fi
