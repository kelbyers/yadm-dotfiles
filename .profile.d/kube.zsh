# SPACESHIP_KUBECONTEXT_SHOW=false
# function k_prompt {
#     [[ $SPACESHIP_KUBECONTEXT_SHOW = true ]] &&
#     SPACESHIP_KUBECONTEXT_SHOW=false ||
#     SPACESHIP_KUBECONTEXT_SHOW=true
# }

if [[ -d $HOME/.kube && -f $HOME/.kube/config ]]; then
    __KUBECONFIGS=( $HOME/.kube/config $(print $HOME/.kube/*.config) )
    if (( ${#__KUBECONFIGS} > 0 )); then
        export KUBECONFIG=${(j/:/)__KUBECONFIGS}
    fi
    unset __KUBECONFIGS
fi
