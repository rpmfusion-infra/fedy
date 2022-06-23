#!/bin/bash

# Remove existing file if it exists.
if [[ -f /etc/profile.d/color_prompt.sh ]]; then
  rm -f /etc/profile.d/color_prompt.sh
fi

# Replace with Git annotations.
cat <<EOF | tee /etc/profile.d/color_status.sh > /dev/null 2>&1
# Quick fork by @mcjim to add stash status and tweak to suit his style.
# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   host dir master $   # clean working directory
#   host dir master* $  # dirty working directory
#   host dir master*^ $  # dirty working directory with stash
#   host dir master^ $  # clean working directory with stash
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_stash {
  [[ $(git stash list 2> /dev/null | tail -n1) != "" ]] && echo "^"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \1$(parse_git_dirty)$(parse_git_stash)/"
}

# Colors in Terminal (Bash)
if [[ ! -z $BASH ]]; then
    if [[ $EUID -eq 0 ]]; then
        PS1='\[\033[33m\][\[\033[m\]\[\033[31m\]\u@\h\[\033[m\] \[\033[33m\]\W\[\e[0;36m\]$(parse_git_branch)\[\e[m\]\[\033[m\]\[\033[33m\]]\[\033[m\] # '
    else
        PS1='\[\033[36m\][\[\033[m\]\[\033[34m\]\u@\h\[\033[m\] \[\033[32m\]\W\[\e[0;36m\]$(parse_git_branch)\[\e[m\]\[\033[m\]\[\033[36m\]]\[\033[m\] $ '
    fi
fi
EOF
