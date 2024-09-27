if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
    export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
    export JAVA_21_HOME=$(/usr/libexec/java_home -v21)

    export JAVA_HOME=$(/usr/libexec/java_home -v21)

    alias java8='export JAVA_HOME=$JAVA_8_HOME'
    alias java17='export JAVA_HOME=$JAVA_17_HOME'
    alias java21='export JAVA_HOME=$JAVA_21_HOME'
fi

# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#if [[ -f "/Users/jxb2016/.sdkman/bin/sdkman-init.sh" ]]; then
#source "/Users/jxb2016/.sdkman/bin/sdkman-init.sh"
#fi

# if which jenv >/dev/null; then
#     eval "$(jenv init -)"
# fi
