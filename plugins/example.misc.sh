# Name: Example plugin
# Command: show_example
# Value: False

show_example() {
zenity --info --title="Example" --text="This is just an example plugin to show how to create plugins"
exit_state
}
