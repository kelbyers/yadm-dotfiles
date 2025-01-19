export def --wrapped main [...rest] {
    run-external choco ...$rest
}

export def --wrapped "choco outdated" [
    ...rest
    --nushell
    --clipboard
] {
    if ($nushell == false) and ($clipboard == false) {
        run-external choco outdated ...$rest
        return
    }

    let output = (run-external choco outdated ...$rest)
    let outdated = (
        $output
        | find '|'
        | str replace --all --regex '[^0-9a-zA-Z|.-]+' ' '
        | str trim
        | str join "\n"
        | from csv --separator '|'
        | rename --block {|c|
            if ($c | str contains "package") {
                "package"
            } else if ($c | str contains "current") {
                "current"
            } else if ($c | str contains "available") {
                "available"
            } else if ($c | str contains "pinned") {
                "pinned"
            } else $c
        }
    )
    if $clipboard {
        $outdated | get package | str join ' ' | pbcopy
        $output
    } else $outdated

}
