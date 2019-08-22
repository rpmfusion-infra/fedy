# Install Fedy

install-core:
	install -dm755 $(DESTDIR)/usr/bin/
	install -dm755 $(DESTDIR)/usr/share/fedy/

	for f in *; do [[ $$f != "plugins" ]] && cp -pr $$f $(DESTDIR)/usr/share/fedy/; done

	install -Dpm 0755 fedy.exec $(DESTDIR)/usr/bin/fedy

	install -Dpm 0644 fedy.desktop $(DESTDIR)/usr/share/applications/org.folkswithhats.fedy.desktop
	install -Dpm 0644 fedy.appdata.xml $(DESTDIR)/usr/share/metainfo/fedy.appdata.xml

	install -Dpm 0644 fedy.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy.svg
	install -Dpm 0644 fedy-symbolic.svg $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy-symbolic.svg

	install -Dpm 0644 run-as-root.policy $(DESTDIR)/usr/share/polkit-1/actions/org.folkswithhats.pkexec.run-as-root.policy

	@-if test -z $(DESTDIR); then gtk-update-icon-cache -f -t $(DESTDIR)/usr/share/icons/hicolor; fi


install-plugins:
	install -dm755 $(DESTDIR)/usr/share/fedy/plugins

	cp -pr plugins/* $(DESTDIR)/usr/share/fedy/plugins/


install: install-core install-plugins


uninstall:
	rm -rf $(DESTDIR)/usr/share/fedy/

	rm -f $(DESTDIR)/usr/bin/fedy

	rm -f $(DESTDIR)/usr/share/applications/org.folkswithhats.fedy.desktop
	rm -f $(DESTDIR)/usr/share/metainfo/fedy.appdata.xml

	rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy.svg
	rm -f $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/fedy-symbolic.svg

	rm -f $(DESTDIR)/usr/share/polkit-1/actions/org.folkswithhats.pkexec.run-as-root.policy

	@-if test -z $(DESTDIR); then gtk-update-icon-cache -f -t $(DESTDIR)/usr/share/icons/hicolor; fi
