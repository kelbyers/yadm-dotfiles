export def main [] {
    let module_dir = $env.FILE_PWD
    let prep_dir = ([$module_dir prep] | path join)

    let modules = (
            ls --short-names $prep_dir
            | where ($it.type == "file")
                and (($it.name | path parse).extension == nu)
            | select name
        )

    let prepared = (
        $modules
        | each {|m|
            let source = ([$module_dir $m.name] | path join)
            let r = (
                nu ([$prep_dir $m.name] | path join)
                | from json
                | default { source: '' }
            )

            if ($r.source | is-not-empty) {
                $r.source | save --force $source
            }

            ({name: $source} | merge ($r | reject source))
        }
    )

    let finalized = (
        $prepared
        | where {|m| 'eval' in ($m | columns)}
        | default [] args
        | each {|m| $"($m.eval) ($m.name)" + (
            if ($m.args | is-not-empty) {
                ' ' + ($m.args | str join ' ')
            } else ''
        ) }
    )

    $finalized
}
