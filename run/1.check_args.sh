# Run: check_args

check_args() {
while [[ $# -gt 0 ]]; do
    case "$1" in
        -l|--enable-log)
                enablelog="yes";;
        -p|--noprev-rel)
                tryprevrel="no";;
        -c|--use-curl)
                downagent="curl";;
        -w|--use-wget)
                downagent="wget";;
        -f|--force-distro)
                forcedistro="yes";;
        -n|--nobakup)
                keepbackup="no";;
        -g|--get)
                forcedown="yes";;
        -r|--redo)
                reinstall="yes";;
        -u|--undo)
                if [[ `grep -w "${2}_undo()" "$plugindir"/*/*.sh` ]]; then
                    interactive="no"
                    while read run; do
                        source "$run"
                    done < <(find "$rundir/" -name *.sh | sort -u)
                    check_root
                    enable_log
                    check_lock
                    check_req
                    initialize_program
                    while [[ $# -gt 1 && `grep -w "${2}_undo()"  "$plugindir"/*/*.sh` ]]; do
                        for plug in "$plugindir"/*/*.sh; do source "$plug"; done
                        eval "${2}_undo"
                        shift
                    done
                    complete_program
                elif [[ $2 = "list" ]]; then
                    echo -e "Usage:\tfedorautils --undo [commands...]"
                    echo -e "\v"
                    for plug in "$plugindir"/*/*.sh; do
                        if [[ `grep "_undo()"  "$plug"` ]]; then
                            command=$(grep "# Command: " "$plug" | sed 's/# Command: //g')
                            name=$(grep "# Name: " "$plug" | sed 's/# Name: //g')
                            printf "\t%-30s%-s\n" "$command" "$name"
                        fi
                    done
                    echo -e "\v"
                    echo -e "See '--help' for more options."
                    exit
                else
                    echo -e "Invalid command '$2'. Try '--undo list' for a list of available commands."
                    exit
                fi;;
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
                    echo -e "\v"
                    echo -e "See '--help' for more options."
                    exit
                else
                    echo -e "Invalid command '$2'. Try '--exec list' for a list of available commands."
                    exit
                fi;;
        -h|--help)
                args=( "-l, --enable-log" "-p, --noprev-rel" "-c, --use-curl" "-w, --use-wget" "-f, --force-distro" "-n, --nobakup" "-g, --redownload" "-r, --redo" "-u, --undo <commands>" "-e, --exec <commands>" "-h, --help" )
                desc=( "enable logging" "disable installing from previous release" "use curl to download files" "use wget to download files" "force run with unsupported distro" "do not keep backup(s)" "force redownload of file(s)" "force redo of the task(s)" "undo the specified task(s)" "execute the specified task(s)" "show this help message and exit" )
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
