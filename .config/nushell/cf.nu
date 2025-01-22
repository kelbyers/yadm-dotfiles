
export def "cf targets" [] {
    use std/log
    run-external cf targets | lines | each {|row|
        log debug $"Checking row: ($row)"
        if (($row | split words | last) == "current") {
            log debug "\tcurrent"
            return {
                target: ($row | str replace ' (current)' '' | str trim),
                status: '(current)'
            }
        } else {
            log debug "\tnot current"
            return {
            target: ($row | str trim),
            status: ''
        }}

    }
}

export def "cf delete-targets" [] {
    let targets = (cf targets)
    if ($targets.0.target | str contains "No targets have been saved") {
        return
    }
    for $it in (cf targets) { cf delete-target $it.target }
}

def targets [] {
    (cf targets | each {|i| $i.target})
}

export extern "cf set-target" [
    target: string@targets
    -f
]
