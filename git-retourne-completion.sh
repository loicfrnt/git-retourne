#!/bin/bash

_delete_branch_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local default=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@')
    [ -z "$default" ] && default='main\|master'
    local branches=$(git branch --format="%(refname:short)" 2> /dev/null | grep -vx "$default")

    COMPREPLY=( $(compgen -W "$branches" -- $cur) )
}

complete -F _delete_branch_completion git-retourne.sh