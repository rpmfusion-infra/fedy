dialog_err() {
yad --name="$program" --class="fedorautils" --window-icon="fedorautils" --borders="10" --fixed --image="gtk-dialog-error" "$@"
}

dialog_warn() {
yad --name="$program" --class="fedorautils" --window-icon="fedorautils" --borders="10" --fixed --image="gtk-dialog-warning" "$@"
}

dialog_info() {
yad --name="$program" --class="fedorautils" --window-icon="fedorautils" --borders="10" --fixed --image="gtk-dialog-info" "$@"
}

dialog_ask() {
yad --name="$program" --class="fedorautils" --window-icon="fedorautils" --borders="10" --fixed --image="gtk-dialog-question" "$@"
}

dialog_show() {
yad --name="$program" --class="fedorautils" --window-icon="fedorautils" --borders="10" "$@"
}
