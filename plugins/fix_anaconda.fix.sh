# Name: Fix anaconda runtime & revisor
# Command: fix_anaconda
# Value: False

fix_anaconda() {
show_func "Fixing anaconda runtime & revisor"
if [[ -e /usr/lib/anaconda-runtime/anaconda ]]; then
show_status "Revisor already fixed"
else
ln -s /usr/lib/anaconda /usr/lib/anaconda-runtime
fi
[[ -e /usr/lib/anaconda-runtime/anaconda ]]; exit_state
}
