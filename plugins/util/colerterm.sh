# Name: Add color prompts to Terminal
# Command: colorterm

colorterm() {
show_func "Adding color prompts to Terminal"
if [[ "$(colorterm_test)" = "Added" ]]; then
    show_status "Color prompts already added"
else
cat <<EOF | tee /etc/profile.d/colorterm.sh > /dev/null 2>&1
# Colors in Terminal
if [ \$USER = root ]; then
    PS1='\[\033[1;31m\][\u@\h \W]\\$\[\033[0m\] '
else
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\\$\[\033[m\] '
fi
EOF
fi
[[ "$(colorterm_test)" = "Added" ]]; exit_state
}

colorterm_undo() {
show_func "Removing color prompts from Terminal"
rm -f /etc/profile.d/colorterm.sh > /dev/null 2>&1
[[ ! "$(colorterm_test)" = "Added" ]]; exit_state
}

colorterm_test() {
if [[ -f /etc/profile.d/colorterm.sh ]]; then
    printf "Added"
else
    printf "Not added"
fi
}
