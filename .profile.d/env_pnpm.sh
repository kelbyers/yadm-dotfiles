# add PNPM global setup for the store and commands to path

if which pnpm > /dev/null; then
    export PNPM_HOME="/Users/jxb2016/Library/pnpm"
    PATH="$PNPM_HOME:$PATH"
    alias pncov="pnpm run coverage"
fi
