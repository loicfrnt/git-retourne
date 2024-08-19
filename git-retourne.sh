#!/bin/bash

branchExists(){
    if git show-ref --verify --quiet refs/heads/$1; then
        return 0
    else
        return 1
    fi
}


# argument 1: target branch to delete, fetch and return to
branch=$1

# if there is no branch called master, use main instead
if branchExists master; then 
    mainBranch='master'
else
    mainBranch='main'

    if branchExists main; then :;
    else 
        echo "No branch called main or master exists."
        exit 1
    fi
fi


# Check if a target branch is provided in arguments, otherwise use the current branch
if [ -z "$branch" ]; then
    branch=$(git branch --show-current)
fi

# Check if the branch is mainBranch
if [ "$branch" = $mainBranch ]; then
    echo "You cannot delete the $mainBranch branch."
    exit 1
fi

# Check if the branch exists
if branchExists $branch; then :;
else
    echo "Branch '$branch' does not exist."
    exit 1
fi

# Prompt for confirmation
read -p "Are you sure you want to delete branch '$branch'? (Y/N): " answer

# Check user's answer
case ${answer:0:1} in
    y|Y )
        # Checkout mainBranch and delete the branch
        git checkout "$mainBranch" && git branch -D "$branch" && git fetch -p && git checkout "$branch"
        ;;
    * )
        echo "Branch deletion canceled."
        ;;
esac
