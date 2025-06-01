#

export def --wrapped nvim [--APP: string, ...rest] {
    with-env { NVIM_APPNAME: $APP } { ^nvim ...$rest }
}

# def --wrapped neovim-start [app_name: string, ...rest] {
#     with-env { NVIM_APPNAME: $app_name } { nvim ...$rest }
# }
#
# export def --wrapped neovim-lazy [...rest] {
#     neovim-start lazyvim ...$rest
# }
#
# export def --wrapped neovim-kickstart [...rest] {
#     neovim-start kickstart.nvim ...$rest
# }
#
# export alias vl = neovim-lazy
# export alias vk = neovim-kickstart

export alias vl = nvim --APP lazyvim
export alias vk = nvim --APP kickstart.nvim
