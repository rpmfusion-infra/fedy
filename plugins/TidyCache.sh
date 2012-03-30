function U_T_TidyCache # Install tidy-cache plugin for yum
{
TidyCache
}

function TidyCache()
{
ShowFunc "Installing tidy-cache plugin for yum"
if [ -f /usr/lib/yum-plugins/tidy-cache.py ]; then
StatusMsg "tidy-cache plugin for yum is already installed"
else
	file="tidy-cache-LATEST.tar.gz"
	get="http://www.hyperdrifter.com/software/files/tidy-cache-LATEST.tar.gz"
	GetFile
	tar xzf "$file"
	cp tidy-cache/tidy-cache.py /usr/lib/yum-plugins/
	cp tidy-cache/tidy-cache.conf /etc/yum/pluginconf.d/
fi
if [ -f /usr/lib/yum-plugins/tidy-cache.py ]; then
Success
else
Failure
fi
}
