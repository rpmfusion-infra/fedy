#!/bin/bash


# Setup variables
LOG_DIR="/var/log/fedy/skype"
LOG_FILE="${LOG_DIR}/skype.log"
RPM_URI="https://go.skype.com/skypeforlinux-64.rpm"


# Add a line feed if the file already exists
if [ -f "$LOG_FILE" ]; then
    echo "" >> "$LOG_FILE"
fi

# Ensure the logs directory exists
if ! command mkdir -p "$LOG_DIR" > /dev/null 2>&1; then
    echo "fedy: skype: fatal: failed  to create $LOG_DIR"
    exit 1
fi


# Helper functions
log() {
    type="$1"
    prefix="fedy: skype"

    shift 1
    case "$type" in
        try_start)
            printf "%s: try: %s" "$prefix" "$*"
            ;;
        try_end)
            printf "%s\n" "$*"
            ;;
        exec)
            log __to_file "${prefix}: exec: $*"
            ;;
        fatal)
            log __to_file "${prefix}: fatal: $*"
            exit 1
            ;;
        __to_file)
            echo "$*" | tee -a "$LOG_FILE"
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
        log fatal "command failed: $action"
    fi
}


# output time info to the log file
echo "FEDY::SKYPE::INSTALL [$(date -u)]" >> "$LOG_FILE"


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
