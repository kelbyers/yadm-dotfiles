
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

export-env {
    $env.CF_CONFIGS_DIR = ([$env.HOME ".cf" "configs"] | path join)
}

# let cf_configs_dir = ([$env.HOME ".cf" "configs"] | path join)

def cf-configs-exists [config?] {
    if ($config | is-not-empty) {
        ([$env.CF_CONFIGS_DIR $config] | path join | path exists)
    } else ($env.CF_CONFIGS_DIR | path exists)
}

def configs [] {
    if (cf-configs-exists) {
        cd $env.CF_CONFIGS_DIR
        (ls | get name)
    } else {
        []
    }
}

# def upsert-config [config: string@configs]

export def --env "cf set-config" [config: string@configs] {
    if (cf-configs-exists $config) == false {
        mkdir ([$env.CF_CONFIGS_DIR $config] | path join)
    }

    $env.CF_HOME = ([$env.CF_CONFIGS_DIR $config] | path join)
    $env.CF_PLUGIN_HOME = ([$env.CF_CONFIGS_DIR '..' 'plugins'] | path join | path expand)
}

export def "cf get-config" [] {
    if 'CF_HOME' not-in $env {
        return "default"
    }
    $env.CF_HOME | path basename
}

export def "cf get-configs" [] {
    configs
}

export def --env "cf rename-config" [orig: string@configs new: string] {
    if (cf-configs-exists $new) {
        let span = (metadata $new).span
        error make {
            msg: $"New config ($new) already exists",
            label: {
                text: "already exists"
                span: $span
            }
        }
    }

    if (cf-configs-exists $orig) {
        mv ([$env.CF_CONFIGS_DIR $orig] | path join) ([$env.CF_CONFIGS_DIR $new] | path join)
        if ((cf get-config) == $orig) {
            (cf set-config $new)
        }
    }
}

export def --env "cf hide-config" [] {
    hide-env CF_HOME CF_PLUGIN_HOME
}

export def --env "cf delete-config" [config: string@configs] {
    if (cf-configs-exists $config) {
        rm -r ([$env.CF_CONFIGS_DIR $config] | path join)
    }
    if ((cf get-config) == $config) {
        cf hide-config
    }
}
