_cook() {
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [[ ${prev} == "cook" ]] ; then
        COMPREPLY=( $(compgen -W "build clean code flash" -- ${cur}) )

    elif [[ ${prev} == "build" ]]; then
        COMPREPLY=( $(compgen -W "test beta release" -- ${cur}) )

    elif [[ ${prev} == "clean" ]]; then
        COMPREPLY=( $(compgen -W "all quick recovery kernel" -- ${cur}) )

    elif [[ ${prev} == "code" ]]; then
        COMPREPLY=( $(compgen -W "full sync merge push status" -- ${cur}) )

    elif [[ ${prev} == "flash" ]]; then
        COMPREPLY=( $(compgen -W "all rom recovery kernel" -- ${cur}) )

    fi
    return 0
}
complete -F _cook cook
