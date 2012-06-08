function Initialize()
{
# Create Additional Directories
mkdir -p "$WORKINGDIR"
mkdir -p "$DOWNLOADSDIR"
StatusMsg "Temporary directory $WORKINGDIR created. Synchronizing files..."
rsync -r -u "$DOWNLOADSDIR/" "$WORKINGDIR"
if [ "$FORCEDOWN" = "YES" ]; then
ShowMsg "Forced mode, $PROGRAM will redownload files even if already downloaded"
fi
cd "$WORKINGDIR"
}
