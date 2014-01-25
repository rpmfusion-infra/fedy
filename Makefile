INSTALL=install
INSTALL_DIRECTORY=$(INSTALL) -dm755
INSTALL_PROGRAM=$(INSTALL) -Dpm 0755
INSTALL_DATA=$(INSTALL) -Dpm 0644
GTK_UPDATE_ICON_CACHE=gtk-update-icon-cache -f -t

all: doc

doc: fez.1
	gzip -c9 fez.1 > fez.1.gz

clean:
	rm -f fez.1.gz

install: doc
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fez/
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fez/lib
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fez/modules
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fez/plugins
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fez/run
	$(INSTALL_PROGRAM) fez $(DESTDIR)/usr/share/fez/fez
	$(INSTALL_PROGRAM) fez.exec $(DESTDIR)/usr/bin/fez
	$(INSTALL_DATA) lib/* $(DESTDIR)/usr/share/fez/lib/
	$(INSTALL_DATA) modules/* $(DESTDIR)/usr/share/fez/modules/
	$(INSTALL_DATA) run/* $(DESTDIR)/usr/share/fez/run/
	for dir in plugins/*; do \
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fez/$$dir; \
	$(INSTALL_DATA) $$dir/* $(DESTDIR)/usr/share/fez/$$dir; \
	done
	$(INSTALL_DATA) fez.1.gz $(DESTDIR)/usr/share/man/man1/fez.1.gz
	$(INSTALL_DATA) fez.appdata.xml $(DESTDIR)/usr/share/appdata/fez.appdata.xml
	$(INSTALL_DATA) fez.desktop $(DESTDIR)/usr/share/applications/fez.desktop
	$(INSTALL_DATA) fez.policy $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fez.policy
	$(INSTALL_DATA) fez.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fez.svg
	@-if test -z $(DESTDIR); then $(GTK_UPDATE_ICON_CACHE) $(DESTDIR)/usr/share/icons/hicolor; fi

uninstall:
	rm -rf $(DESTDIR)/usr/share/fez/
	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fez.policy
	rm -f $(DESTDIR)/usr/share/man/man1/fez.1.gz
	rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fez.svg
	rm -f $(DESTDIR)/usr/share/applications/fez.desktop
	rm -f $(DESTDIR)/usr/share/appdata/fez.appdata.xml
	rm -f $(DESTDIR)/usr/bin/fez
	@-if test -z $(DESTDIR); then $(GTK_UPDATE_ICON_CACHE) $(DESTDIR)/usr/share/icons/hicolor; fi
