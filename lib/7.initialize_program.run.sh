# Run: initialize_program

initialize_program() {
# Create Additional Directories
mkdir -p "$workingdir"
mkdir -p "$downloadsdir"
show_status "Temporary directory $workingdir created. Synchronizing files..."
rsync -r -u "$downloadsdir/" "$workingdir"
[[ "$forcedown" = "yes" ]] && show_warn "$program will force redownload of files even if already downloaded"
cd "$workingdir"
[[ $? -eq 0 ]] || terminate_program
# Check for updates
show_update &
}
