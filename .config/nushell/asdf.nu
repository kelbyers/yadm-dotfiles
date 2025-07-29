# nu shell integration for asdf
$env.ASDF_DIR = ($env.HOME | path join '.asdf')

let shims_dir = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)
$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

# Nu shell completion for asdf
source "~/.asdf/completions/nushell.nu"
