# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# $env.config.buffer_editor = "notepad++"

source ~/.config/nushell/config-local.nu

$env.config.buffer_editor = "code"
$env.STARSHIP_CONFIG = "~/.config/starship.toml"

use ~/.config/nushell/cal3.nu *
use ~/.config/nushell/clipboard.nu *
use ~/.config/nushell/git.nu *
use ~/.config/nushell/starship.nu

source ~/.config/nushell/carapace.nu
source ~/.config/nushell/direnv.nu
source ~/.config/nushell/zoxide.nu

# trim the PATH to only include existing directories, and remove duplicates
$env.PATH = ($env.PATH | uniq | where ($it | path exists))
