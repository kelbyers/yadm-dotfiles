{
    eval: 'use'
    args: ['*']
    source: (open ([$env.FILE_PWD calX.nusrc] | path join))
} | to json
