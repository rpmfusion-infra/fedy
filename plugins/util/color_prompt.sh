# Name: Add color prompts to Terminal
# Command: color_prompt

color_prompt() {
show_func "Adding color prompts to Terminal"
if [[ "$(color_prompt_test)" = "Added" ]]; then
    show_status "Color prompts already added"
else
cat <<EOF | tee /etc/profile.d/color_prompt.sh > /dev/null 2>&1
# Colors in Terminal (Bash)
if [[ ! -z \$BASH ]]; then
    if [[ \$USER = "root" ]]; then
        PS1="\[\033[33m\][\[\033[m\]\[\033[31m\]\u@\h\[\033[m\] \[\033[33m\]\W\[\033[m\]\[\033[33m\]]\[\033[m\] \# "
    
    elif [[ $(whoami) = "root" ]]; then
        PS1="\[\033[33m\][\[\033[m\]\[\033[31m\]\u@\h\[\033[m\] \[\033[33m\]\W\[\033[m\]\[\033[33m\]]\[\033[m\] \# "
    
    else
        PS1="\[\033[36m\][\[\033[m\]\[\033[34m\]\u@\h\[\033[m\] \[\033[32m\]\W\[\033[m\]\[\033[36m\]]\[\033[m\] \$ "
    fi
fi
EOF
fi
[[ "$(color_prompt_test)" = "Added" ]]; exit_state
}

color_prompt_undo() {
show_func "Removing color prompts from Terminal"
rm -f /etc/profile.d/color_prompt.sh > /dev/null 2>&1
[[ ! "$(color_prompt_test)" = "Added" ]]; exit_state
}

color_prompt_test() {
if [[ -f /etc/profile.d/color_prompt.sh ]]; then
    printf "Added"
else
    printf "Not added"
fi
}
