INSTALL=install
INSTALL_DIRECTORY=$(INSTALL) -dm755
INSTALL_PROGRAM=$(INSTALL) -Dpm 0755
INSTALL_DATA=$(INSTALL) -Dpm 0644
GTK_UPDATE_ICON_CACHE=gtk-update-icon-cache -f -t

install:
	$(INSTALL_PROGRAM) run-as-root $(DESTDIR)/usr/bin/run-as-root
	$(INSTALL_DATA) run-as-root.policy $(DESTDIR)/usr/share/polkit-1/actions/org.ozonos.pkexec.run-as-root.policy

uninstall:
	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.ozonos.pkexec.run-as-root.policy
	rm -f $(DESTDIR)/usr/bin/run-as-root
