# Install Fedy

install:
	install -dm755 $(DESTDIR)/usr/bin/
	install -dm755 $(DESTDIR)/usr/share/fedy/

	for f in *; do cp -pr $$f $(DESTDIR)/usr/share/fedy/; done

	install -Dpm 0644 fedy.exec $(DESTDIR)/usr/bin/fedy
	install -Dpm 0644 fedy.appdata.xml $(DESTDIR)/usr/share/appdata/fedy.appdata.xml
	install -Dpm 0644 fedy.desktop $(DESTDIR)/usr/share/applications/fedy.desktop
	install -Dpm 0644 fedy.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy.svg

	install -Dpm 0644 run-as-root.policy $(DESTDIR)/usr/share/polkit-1/actions/org.ozonos.pkexec.run-as-root.policy

	@-if test -z $(DESTDIR); then gtk-update-icon-cache -f -t $(DESTDIR)/usr/share/icons/hicolor; fi

uninstall:
	rm -rf $(DESTDIR)/usr/share/fedy/
	rm -f $(DESTDIR)/usr/bin/fedy

	rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy.svg
	rm -f $(DESTDIR)/usr/share/applications/fedy.desktop
	rm -f $(DESTDIR)/usr/share/appdata/fedy.appdata.xml

	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.ozonos.pkexec.run-as-root.policy

	@-if test -z $(DESTDIR); then gtk-update-icon-cache -f -t $(DESTDIR)/usr/share/icons/hicolor; fi
