# code: language=shellscript
# set up rancher desktop
_RD=$HOME/.rd
_RDBIN=$_RD/bin
if [[ -d $_RDBIN ]]; then
    PATH=$_RDBIN:$PATH
fi
unset _RD _RDBIN
