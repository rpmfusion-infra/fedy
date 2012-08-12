initialize_program() {
# Create Additional Directories
mkdir -p "$workingdir"
mkdir -p "$downloadsdir"
show_status "Temporary directory $workingdir created. Synchronizing files..."
rsync -r -u "$downloadsdir/" "$workingdir"
if [[ "$forcedown" = "yes" ]]; then
show_warn "$program will force redownload of files even if already downloaded"
fi
cd "$workingdir"
}
