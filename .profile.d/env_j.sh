if [[ -f /usr/libexec/java_home ]]; then 
    export JAVA_HOME=$(/usr/libexec/java_home -v17)

    export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
    export JAVA_17_HOME=$(/usr/libexec/java_home -v17)

    alias java8='export JAVA_HOME=$JAVA_8_HOME'
    alias java17='export JAVA_HOME=$JAVA_17_HOME'
fi
# if which jenv >/dev/null; then
#     eval "$(jenv init -)"
# fi
