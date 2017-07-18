#!/bin/bash




# Setup variables
LOG_DIR="/tmp/fedy/logs"
LOG_FILE="${LOG_DIR}/skype.log"
RPM_URI="https://go.skype.com/skypeforlinux-64.rpm"


# Helper functions
log() {
    prefix="fedy: skype"

    case "$1" in
        exec)
            shift
            echo "${prefix}: exec: $*" | tee -a "$LOG_FILE"
            ;;
        try_start)
            shift
            printf "${prefix}: try: $*"
            ;;
        try_end)
            shift
            printf "$*\n"
            ;;
        error)
            shift
            echo "${prefix}: error: $*" | tee -a "$LOG_FILE"
            ;;
        fatal)
            shift
            echo "${prefix}: fatal: $*" | tee -a "$LOG_FILE"
            exit 1
            ;;
    esac
}

runCmd() {
    log exec "$*"
    $* >> "$LOG_FILE" 2>&1
}

try() {
    action="$1"

    log try_start "$2... "
    if runCmd "$action" > /dev/null 2>&1; then
        log try_end "[ OK ]"
    else
        log try_end "[ FAIL ]"
        log error "command failed: $action"
    fi
}


# output time info to the log file
echo "\n FEDY::SKYPE::INSTALL $(date)" >> "$LOG_FILE"


# Ensure the logs directory exists
try \
    "mkdir -p $LOG_DIR" \
    "creating $LOG_DIR"


# Early fail checks
if [ "$(uname --machine)" = "i686" ]; then
    # Fail early if the host machine is 32-bit
    log fatal "32-bit machines are not supported"
elif [ "$(whoami)" != "root" ]; then
    # Fail early if the user is not root
    log fatal "installation must be executed as the root user"
fi


try \
    "dnf -y install $RPM_URI" \
    "installing $RPM_URI"
