#!/bin/bash

WHITE="\033[1;37m"
RED="\033[0;31m"
RESET_COLOR="\033[0m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

# CHECK ARGUMENTS :

while [ ! -z "$1" ]; do
  case "$1" in
  --username | -n)
    shift
    USERNAME=$1
    ;;
  *) ;;
  esac
  shift
done

# CLEAN REPO : 
echo ""
echo -e "${YELLOW}# cleaning repo with username : ${RED}$USERNAME${RESET_COLOR}"
echo ""

# SET GIT CONFIGS : 

git config --global user.username $USERNAME
git config --global user.name $USERNAME
git config --global user.email "${USERNAME}@gmail.com"

default_branch=`basename $(git symbolic-ref --short refs/remotes/origin/HEAD)`

# CLEAN REPO : 
echo ""
echo -e "${YELLOW}# default branch name : ${RED}$default_branch${RESET_COLOR}"
echo ""

git checkout --orphan tmp
git add -A # Add all files and commit them
git commit -m "blast off 🚀" # temp message
git branch -D $default_branch # Deletes the default branch
git branch -m $default_branch # Rename the current branch to default
git push -f origin $default_branch # Force push default branch to github
git gc --aggressive --prune=all # remove the old files
git push --set-upstream origin $default_branch