export-env {
    if ('/opt/homebrew/bin' | path exists) {
        $env.PATH = (
            $env.PATH
            | split row (char esep)
            | prepend [
                '/opt/homebrew/bin'
                '/opt/homebrew/sbin'
            ]
        )
    }
}
