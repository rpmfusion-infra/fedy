# Run: initialize_program

initialize_program() {
# Create Additional Directories
mkdir -p "$workingdir"
mkdir -p "$downloadsdir"
show_status "Synchronizing files to $workingdir"
rsync -r -u "$downloadsdir/" "$workingdir"
[[ "$redownload" = "true" ]] && show_warn "$program will force redownload of files even if already downloaded"
# Restore SELinux context
chcon -R -t default_t "$workingdir"
cd "$workingdir"
[[ $? -eq 0 ]] || terminate_program
# Check for updates
show_update
}
