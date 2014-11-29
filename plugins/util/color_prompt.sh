# Name: Add color prompts to Terminal
# Command: color_prompt

color_prompt() {
show_func "Adding color prompts to Terminal"
if [[ "$(color_prompt_test)" = "Added" ]]; then
    show_status "Color prompts already added"
else
touch /etc/sysconfig/bash-prompt-xterm.orig
mv -f /etc/sysconfig/bash-prompt-xterm /etc/sysconfig/bash-prompt-xterm.orig > /dev/null 2>&1
cat <<EOF | tee /etc/sysconfig/bash-prompt-xterm > /dev/null 2>&1
# Colors in Terminal
if [ \$USER = root ]; then
    echo -n '\[\033[1;31m\][\u@\h \W]\\$\[\033[0m\] '
else
    echo -n '\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\\$\[\033[m\] '
fi
EOF
fi
[[ "$(color_prompt_test)" = "Added" ]]; exit_state
}

color_prompt_undo() {
show_func "Removing color prompts from Terminal"
rm -f /etc/sysconfig/bash-prompt-xterm > /dev/null 2>&1
mv -f /etc/sysconfig/bash-prompt-xterm.orig /etc/sysconfig/bash-prompt-xterm > /dev/null 2>&1
[[ $(stat -c%s /etc/sysconfig/bash-prompt-xterm) -eq 0 ]] && rm /etc/sysconfig/bash-prompt-xterm
[[ ! "$(color_prompt_test)" = "Added" ]]; exit_state
}

color_prompt_test() {
if [[ -f /etc/sysconfig/bash-prompt-xterm.orig ]]; then
    printf "Added"
else
    printf "Not added"
fi
}
