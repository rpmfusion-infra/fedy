# Run: check_args

check_args() {
while [[ $# -gt 0 ]]; do
    case "$1" in
        -l|--enable-log)
                enablelog="yes";;
        -p|--noprev-rel)
                tryprevrel="no";;
        -c|--pref-curl)
                prefwget="no";;
        -w|--use-wget)
                downagent="wget";;
        -r|--redo-task)
                reinstall="yes";;
        -g|--redownload)
                forcedown="yes";;
        -f|--force-distro)
                forcedistro="yes";;
        -n|--nobakup)
                keepbackup="no";;
        -d|--debug)
                if [[ -r "$logfile" ]]; then
                    cat "$logfile"
                else
                    echo -e "No logfile exists. Try running again with logging enabled. Use '--help' for more details"
                fi
                exit;;
        -e|--exec)
                if [[ `grep -w "# Command: $2" "$plugindir"/*/*.sh` ]]; then
                    interactive="no"
                    while read run; do
                        source "$run"
                    done < <(find "$rundir/" -name *.sh | sort -u)
                    check_root
                    enable_log
                    check_lock
                    check_req
                    initialize_program
                    while [[ $# -gt 1 && `grep -w "# Command: $2"  "$plugindir"/*/*.sh` ]]; do          
                        for plug in "$plugindir"/*/*.sh; do source "$plug"; done
                        eval "$2"
                        shift
                    done
                    complete_program
                elif [[ $2 = "list" ]]; then
                    echo -e "Usage:\tfedorautils --exec [commands...]"
                    echo -e "\v"
                    for plug in "$plugindir"/*/*.sh; do
                        command=$(grep "# Command: " "$plug" | sed 's/# Command: //g')
                        name=$(grep "# Name: " "$plug" | sed 's/# Name: //g')
                        printf "\t%-30s%-s\n" "$command" "$name"
                    done
                    exit
                else
                    echo -e "Invalid command '$2'. Try '--exec list' for a list of available commands."
                    exit
                fi;;
        -h|--help)
                args=( "-l, --enable-log" "-p, --noprev-rel" "-c, --pref-curl" "-w, --use-wget" "-r, --redo-task" "-g, --redownload" "-f, --force-distro" "-n, --nobakup" "-e, --exec <commands>" "-d, --debug" "-h, --help" )
                desc=( "enable logging" "disable installing from previous release" "prefer curl over wget unless specified" "use wget for download instead of curl" "redo the specified task" "force redownload of files" "run with unsupported distro" "do not keep backups" "execute commands from the plugins" "show last logfile and exit" "show this help message and exit" )
                echo -e "Usage:\tfedorautils [options...]"
                echo -e "\v"
                for ((i=0; i < ${#args[@]}; i++)); do
                    printf "\t%-30s%-s\n" "${args[i]}" "${desc[i]}"
                done
                echo -e "\v"
                echo -e "See the man page for more help."
                exit;;
        -?|--*)
                echo -e "Unrecognized option '$1'. Try '--help' for all available options."
                exit;;
        -*)
                args=$1
                shift
                set -- $(echo "$args" | cut -c 2- | sed 's/./-& /g') "$@"
                continue;;
        *)
                break;;
    esac
    shift
done
}
