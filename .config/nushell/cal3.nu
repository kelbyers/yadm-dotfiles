export def main [when?] {
    let first = ((if ($when == null) {(date now)} else ($when | into datetime)) - 5wk)

    # list of all months to show, [{month: MONTH, year: YEAR} ...]
    let months = (
        (
            ($first | into int)..(($first + 1wk) | into int)..(($first + 10wk) | into int)
            | into datetime
        )
        | each {|d| {
            month: ($d | format date "%m" | into int)
            year: ($d | format date "%Y" | into int)
        }}
        | uniq
    )

    (
        # for each YEAR in $months, get full calendar for that year
        ($months | get year | uniq) | each {|year|
            (cal --year --month --as-table --full-year $year)
        }
        # squash multiple years down into single table
        | flatten
        # filter out all rows from table that are not in the list of $months
        | where ({month: $it.month year: $it.year} in $months)
    )
}
