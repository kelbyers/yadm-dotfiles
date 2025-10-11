# uv installs python into `~/.local/bin
export-env {
    let local_bin = ('~/.local/bin' | path expand)
    if ($local_bin | path exists) {
        $env.PATH = (
            $env.PATH
            | split row (char esep)
            | prepend [ $local_bin ]
        )
    }
}
