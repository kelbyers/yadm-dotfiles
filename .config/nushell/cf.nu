
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

# def api_endpoints [] {
#   {  [
#         "https://api.run-eb.homedepot.com",
#         "https://api.run-za.homedepot.com",
#         "https://api.run-zb.homedepot.com",
#         "https://api.runpa.homedepot.com",
#         "https://api.runps.homedepot.com",
#         "https://api.run-at.homedepot.com",
#         "https://api.run-np.homedepot.com",
#         "https://api.run.at.ssc.vsphere.platforms.homedepot.com",
#         "https://api.run.np.ssc.vsphere.platforms.homedepot.com"
#     ]}
# }

def make-args [flag value] {
    if ($value != null) {[$flag $value]}
}

# export extern "cf login" [
#     -a : string@api_endpoints,
#     ...rest
# ]

# export def --wrapped "cf login" [
#     --API_endpoint (-a) : string@api_endpoints,
#     --username (-u) : string,
#     --org (-o) : string,
#     --space (-s) : string,
#     ...rest
# ] {
#     let args = (
#         [
#             (make-args "-a" $API_endpoint)
#             (make-args "-u" $username)
#             (make-args "-o" $org)
#             (make-args "-s" $space)
#         ]
#         | flatten | lines --skip-empty | str join " "
#     )
#     run-external cf login $args ...$rest
# }

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

def --env cf-set-config [config] {
    if (cf-configs-exists $config) == false {
        mkdir ([$env.CF_CONFIGS_DIR $config] | path join)
    }

    $env.CF_HOME = ([$env.CF_CONFIGS_DIR $config] | path join)
    $env.CF_PLUGIN_HOME = ([$env.CF_CONFIGS_DIR '..' 'plugins'] | path join | path expand)
}

export def --env "cf set-config" [config: string@configs] {
    cf-set-config $config
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

export def --env "cf rename-config" [
    orig: string@configs
    new: string
    --force (-f)
] {
    if (cf-configs-exists $new) {
        if $force {
            rm -r ([$env.CF_CONFIGS_DIR $new] | path join)
        } else {
            let span = (metadata $new).span
            error make {
                msg: $"New config ($new) already exists",
                label: {
                    text: "already exists"
                    span: $span
                }
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

export def "cf copy-config" [
    orig: string@configs
    new: string
    --force (-f)
] {
    if (cf-configs-exists $new) {
        if $force {
            rm -r ([$env.CF_CONFIGS_DIR $new] | path join)
        } else {
            let span = (metadata $new).span
            error make {
                msg: $"New config ($new) already exists",
                label: {
                    text: "already exists"
                    span: $span
                }
            }
        }    }

    if (cf-configs-exists $orig) {
        cp -r ([$env.CF_CONFIGS_DIR $orig] | path join) ([$env.CF_CONFIGS_DIR $new] | path join)
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

def with-default [val default_val] {
    if ($val | is-empty) { $default_val } else $val
}

export def --wrapped "cf relogin" [
    --API_endpoint (-a) : string #@api_endpoints,
    --username (-u) : string
    --org (-o) : string
    --space (-s) : string
    ...rest
] {
    let loaded_target = (
        (cf target | from ssv --noheaders | transpose --header-row).0
        | rename --block {str replace ':' '' | str replace ' ' '_'}
    )
    let target = ({
        API_endpoint: (with-default $API_endpoint $loaded_target.API_endpoint),
        user: (with-default $username $loaded_target.user),
        org: (with-default $org $loaded_target.org),
        space: (with-default $space $loaded_target.space)
    } )


    print $"Relogging in as ($target.user) to org ($target.org) and space ($target.space) on ($target.API_endpoint)..."

    cf login -s $target.space -o $target.org -u $target.user -a $target.API_endpoint ...$rest
}

export def --wrapped "cf-in" [config ...rest] {
    cf-set-config $config
    print $"Using config: ($config)"
    cf $rest.0 (...$rest | skip 1)
}

export alias cfat = cf-in "at"
export alias cfat2 = cf-in "at2"
export alias cfat3 = cf-in "at3"
export alias cfnp = cf-in "np"
export alias cfeb = cf-in "eb"
export alias cfza = cf-in "za"
export alias cfzb = cf-in "zb"
