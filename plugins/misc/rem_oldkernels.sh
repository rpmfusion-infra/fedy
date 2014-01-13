# Name: Remove old kernels
# Command: rem_oldkernels

rem_oldkernels() {
if [[ ! "$interactive" = "no" ]]; then
    show_dialog --title="Remove all old kernels?" --text="Keeping old kernels might be helpful in case you face any problem with the current kernel. If you proceed, $program will invoke the <b><i>package-cleanup</i></b> command to remove all old kernels except the current running kernel. Do you want to proceed?" --button="No:1" --button="Yes:0"
    if [[ $? -eq 1 ]]; then
        return
    fi
fi
show_func "Removing old kernels"
package-cleanup -y --oldkernels --count=1
exit_state
}
