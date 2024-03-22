#!/bin/bash

branch=$1

# Check if a branch is provided
if [ -z "$branch" ]; then
    branch=$(git branch --show-current)
fi

# Check if the branch is master
if [ "$branch" = "master" ]; then
    echo "You cannot delete the master branch."
    exit 1
fi

# Check if the branch exists
git show-ref --verify --quiet refs/heads/${branch}
if [ $? -ne 0 ]; then
    echo "Branch '$branch' does not exist."
    exit 1
fi

# Prompt for confirmation
read -p "Are you sure you want to delete branch '$branch'? (Y/N): " answer

# Check user's answer
case ${answer:0:1} in
    y|Y )
        # Checkout master and delete the branch
        git checkout master && git branch -D "$branch" && git fetch -p && git checkout "$branch"
        ;;
    * )
        echo "Branch deletion canceled."
        ;;
esac