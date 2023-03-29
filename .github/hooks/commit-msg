#!/bin/sh

# Only populate commit message if it is empty
if [ -z "$(cat "$1")" ]; then
    # Get name of current branch
    BRANCH_NAME=$(git branch --show-current)

    # Extract type and scope from branch name
    IFS='-' read -r TYPE SCOPE <<< "$BRANCH_NAME"

    # Template for commit message
    COMMIT_MSG_TEMPLATE="[$TYPE]($SCOPE): "

    echo "$COMMIT_MSG_TEMPLATE" > "$1"
fi
