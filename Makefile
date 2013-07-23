INSTALL=install
INSTALL_DIRECTORY=$(INSTALL) -dm755
INSTALL_PROGRAM=$(INSTALL) -Dpm 0755
INSTALL_DATA=$(INSTALL) -Dpm 0644
GTK_UPDATE_ICON_CACHE=gtk-update-icon-cache -f -t

all: doc

doc: fedorautils.1
	gzip -c9 fedorautils.1 > fedorautils.1.gz

clean:
	rm -f fedorautils.1.gz

install: doc
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/run
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/lib
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/modules
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/plugins
	$(INSTALL_PROGRAM) fedorautils $(DESTDIR)/usr/share/fedorautils/fedorautils
	$(INSTALL_PROGRAM) fedorautils.exec $(DESTDIR)/usr/bin/fedorautils
	$(INSTALL_DATA) lib/* $(DESTDIR)/usr/share/fedorautils/lib/
	$(INSTALL_DATA) run/* $(DESTDIR)/usr/share/fedorautils/run/
	$(INSTALL_DATA) modules/* $(DESTDIR)/usr/share/fedorautils/modules/
	for dir in plugins/*; do \
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/$$dir; \
	$(INSTALL_DATA) $$dir/* $(DESTDIR)/usr/share/fedorautils/$$dir; \
	done
	$(INSTALL_DATA) fedorautils.desktop $(DESTDIR)/usr/share/applications/fedorautils.desktop
	$(INSTALL_DATA) fedorautils.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedorautils.svg
	$(INSTALL_DATA) fedorautils.1.gz $(DESTDIR)/usr/share/man/man1/fedorautils.1.gz
	$(INSTALL_DATA) fedorautils.policy $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fedorautils.policy
	@-if test -z $(DESTDIR); then $(GTK_UPDATE_ICON_CACHE) $(DESTDIR)/usr/share/icons/hicolor; fi

uninstall:
	rm -rf $(DESTDIR)/usr/share/fedorautils/
	rm -f $(DESTDIR)/usr/bin/fedorautils
	rm -f $(DESTDIR)/usr/share/applications/fedorautils.desktop
	rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedorautils.svg
	rm -f $(DESTDIR)/usr/share/man/man1/fedorautils.1.gz
	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fedorautils.policy
	@-if test -z $(DESTDIR); then $(GTK_UPDATE_ICON_CACHE) $(DESTDIR)/usr/share/icons/hicolor; fi
