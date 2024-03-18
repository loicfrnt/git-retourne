#!/bin/bash

_delete_branch_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local branches=$(git branch --format="%(refname:short)" 2> /dev/null | grep -v "master")

    COMPREPLY=( $(compgen -W "$branches" -- $cur) )
}

complete -F _delete_branch_completion git-retourne.sh