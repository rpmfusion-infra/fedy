# Name: Example plugin
# Command: show_example

show_example() {
show_func "Starting example plugin"
zenity --info --title="Example" --text="This is just an example plugin to show how to create plugins"
exit_state
}
