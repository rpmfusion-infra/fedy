INSTALL=install
INSTALL_DIRECTORY=$(INSTALL) -dm755
INSTALL_PROGRAM=$(INSTALL) -Dpm 0755
INSTALL_DATA=$(INSTALL) -Dpm 0644
GTK_UPDATE_ICON_CACHE=gtk-update-icon-cache -f -t

all: doc

doc: fedy.1
	gzip -c9 fedy.1 > fedy.1.gz

clean:
	rm -f fedy.1.gz

install: doc
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedy/
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedy/lib
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedy/modules
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedy/plugins
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedy/run
	$(INSTALL_PROGRAM) fedy $(DESTDIR)/usr/share/fedy/fedy
	$(INSTALL_PROGRAM) fedy.exec $(DESTDIR)/usr/bin/fedy
	$(INSTALL_DATA) lib/* $(DESTDIR)/usr/share/fedy/lib/
	$(INSTALL_DATA) modules/* $(DESTDIR)/usr/share/fedy/modules/
	$(INSTALL_DATA) run/* $(DESTDIR)/usr/share/fedy/run/
	for dir in plugins/*; do \
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedy/$$dir; \
	$(INSTALL_DATA) $$dir/* $(DESTDIR)/usr/share/fedy/$$dir; \
	done
	$(INSTALL_DATA) fedy.1.gz $(DESTDIR)/usr/share/man/man1/fedy.1.gz
	$(INSTALL_DATA) fedy.appdata.xml $(DESTDIR)/usr/share/appdata/fedy.appdata.xml
	$(INSTALL_DATA) fedy.desktop $(DESTDIR)/usr/share/applications/fedy.desktop
	$(INSTALL_DATA) fedy.policy $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fedy.policy
	$(INSTALL_DATA) fedy.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy.svg
	@-if test -z $(DESTDIR); then $(GTK_UPDATE_ICON_CACHE) $(DESTDIR)/usr/share/icons/hicolor; fi

uninstall:
	rm -rf $(DESTDIR)/usr/share/fedy/
	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fedy.policy
	rm -f $(DESTDIR)/usr/share/man/man1/fedy.1.gz
	rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy.svg
	rm -f $(DESTDIR)/usr/share/applications/fedy.desktop
	rm -f $(DESTDIR)/usr/share/appdata/fedy.appdata.xml
	rm -f $(DESTDIR)/usr/bin/fedy
	@-if test -z $(DESTDIR); then $(GTK_UPDATE_ICON_CACHE) $(DESTDIR)/usr/share/icons/hicolor; fi
