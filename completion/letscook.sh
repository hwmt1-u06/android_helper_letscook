_cook() {
    local cur len prev prev2 prev3
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    len=${#COMP_WORDS[@]}
    if [[ $len -gt 1 ]]; then
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        if [[ ${prev} == "cook" ]]; then
            COMPREPLY=( $(compgen -W "build clean code flash" -- ${cur}) )
        fi
    fi
    if [[ $len -gt 2 ]]; then
        prev2="${COMP_WORDS[COMP_CWORD-2]}"
        if [[ ${prev2} == "cook" ]]; then
            if [[ ${prev} == "build" ]]; then
                COMPREPLY=( $(compgen -W "test beta release" -- ${cur}) )
            elif [[ ${prev} == "clean" ]]; then
                COMPREPLY=( $(compgen -W "all quick recovery kernel" -- ${cur}) )
            elif [[ ${prev} == "code" ]]; then
                COMPREPLY=( $(compgen -W "full sync merge push status" -- ${cur}) )
            elif [[ ${prev} == "flash" ]]; then
                COMPREPLY=( $(compgen -W "all rom recovery kernel" -- ${cur}) )
            fi
        fi
    fi
    if [[ $len -gt 3 ]]; then
        prev3="${COMP_WORDS[COMP_CWORD-3]}"
        if [[ ${prev3} == "cook" ]]; then
            if [[ ${prev2} == "build" ]]; then
                COMPREPLY=( $(compgen -W "-v -c -k -u" -- ${cur}) )
            elif [[ ${prev2} == "clean" ]]; then
                COMPREPLY=( $(compgen -W "-s" -- ${cur}) )
            elif [[ ${prev2} == "code" ]]; then
                COMPREPLY=( $(compgen -W "-s" -- ${cur}) )
            elif [[ ${prev2} == "flash" ]]; then
                if [[ ${prev} == "recovery" ]]; then
                    COMPREPLY=( $(compgen -W "-s -a" -- ${cur}) )
                else
                    COMPREPLY=( $(compgen -W "-s" -- ${cur}) )
                fi
            fi
        fi
    fi
    return 0
}
complete -F _cook cook
