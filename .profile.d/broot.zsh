# -- Run broot, eval cmdfile if successful --
br () {  # [<broot-opt>...]
  emulate -L zsh

  local cmdfile=$(mktemp)
  trap "rm ${(q-)cmdfile}" EXIT INT QUIT
  if { broot --outcmd "$cmdfile" $@ } {
    if [[ -r $cmdfile ]]  eval "$(<$cmdfile)"
  } else {
    return
  }
}
