let os = (uname | get kernel-name)

if (os == 'Windows_NT') {
    let bash = 'C:\Program Files\Git\usr\bin\bash.exe'

    if (($bash | path exists) == false ) { return {} }

    let which = 'C:\Program Files\Git\usr\bin\which.exe'
    let yadm = (^which yadm)

    # let script = r#'def yadm [...args] { run-external 'C:\Program Files\Git\usr\bin\bash' '/c/Users/kel/bin/yadm' ...$args }'#


    {
        eval: 'source'
        source: $script
    } | to json
} else {}
