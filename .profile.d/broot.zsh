# # -- Run broot, eval cmdfile if successful --
# br () {  # [<broot-opt>...]
#   emulate -L zsh

#   local cmdfile=$(mktemp)
#   trap "rm ${(q-)cmdfile}" EXIT INT QUIT
#   if { broot --outcmd "$cmdfile" $@ } {
#     if [[ -r $cmdfile ]]  eval "$(<$cmdfile)"
#   } else {
#     return
#   }
# }

zmodload zsh/mapfile

# -- Run broot, cd into pathfile if successful --
# Depends: zmapfile
br () {  # [<broot-opt>...]
  emulate -L zsh -o localtraps

  local pathfile=$(mktemp)
  trap "=rm ${(q-)pathfile}" EXIT INT QUIT
  if { broot --verb-output "$pathfile" $@ } {
    if [[ -r $pathfile ]] {
      local folder=${mapfile[$pathfile]}
      if [[ $folder ]]  cd $folder
    }
  } else {
    return
  }
}


# -- Clear line, run broot, restore line --
# Key: ctrl+b
# Depends: br
.zle_broot () {
  zle .push-input
  BUFFER="br"
  zle .accept-line
}
zle -N       .zle_broot
bindkey '^b' .zle_broot  # ctrl+b
