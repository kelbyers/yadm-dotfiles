export def main [] {
    let first = ((date now) - 5wk)
    let last = ($first + 10wk)
    (
        cal --month --as-table --full-year (
            $first | format date %Y | into int
        )
        | where month >= (
            $first | format date %m | into int
        )
        | append (
            cal --month --as-table --full-year (
                $last | format date %Y | into int
            )
            | where month <= ($last | format date %m | into int)
        )
    )
}
