## Spaceship Prompt Customizations
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_HOST_SHOW=always
if [[ "$(uname -o)" = "Cygwin" ]]; then
    SPACESHIP_PROMPT_ASYNC=false
fi
