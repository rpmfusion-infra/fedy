INSTALL=install
INSTALL_DIRECTORY=$(INSTALL) -dm755
INSTALL_PROGRAM=$(INSTALL) -Dpm 0755
INSTALL_DATA=$(INSTALL) -Dpm 0644

all: doc

doc: fedorautils.1
	gzip -c9 fedorautils.1 > fedorautils.1.gz

clean:
	rm -f fedorautils.1.gz

install: doc
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/lib
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/modules
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/plugins
	$(INSTALL_DIRECTORY) $(DESTDIR)/usr/share/fedorautils/support
	$(INSTALL_PROGRAM) fedorautils $(DESTDIR)/usr/share/fedorautils/fedorautils
	$(INSTALL_PROGRAM) fedorautils.exec $(DESTDIR)/usr/bin/fedorautils
	$(INSTALL_DATA) lib/* $(DESTDIR)/usr/share/fedorautils/lib/
	$(INSTALL_DATA) modules/* $(DESTDIR)/usr/share/fedorautils/modules/
	$(INSTALL_DATA) plugins/* $(DESTDIR)/usr/share/fedorautils/plugins/
	$(INSTALL_DATA) support/* $(DESTDIR)/usr/share/fedorautils/support/
	$(INSTALL_DATA) fedorautils.desktop $(DESTDIR)/usr/share/applications/fedorautils.desktop
	$(INSTALL_DATA) fedorautils.1.gz $(DESTDIR)/usr/share/man/man1/fedorautils.1.gz
	$(INSTALL_DATA) fedorautils.png $(DESTDIR)/usr/share/pixmaps/fedorautils.png
	$(INSTALL_DATA) fedorautils.policy $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fedorautils.policy
	$(INSTALL_DATA) fedorautils.repo $(DESTDIR)/etc/yum.repos.d/fedorautils.repo

uninstall:
	rm -rf $(DESTDIR)/usr/share/fedorautils/
	rm -f $(DESTDIR)/usr/bin/fedorautils
	rm -f $(DESTDIR)/usr/share/applications/fedorautils.desktop
	rm -f $(DESTDIR)/usr/share/man/man1/fedorautils.1.gz
	rm -f $(DESTDIR)/usr/share/pixmaps/fedorautils.png
	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.freedesktop.pkexec.fedorautils.policy
	rm -f $(DESTDIR)/etc/yum.repos.d/fedorautils.repo
