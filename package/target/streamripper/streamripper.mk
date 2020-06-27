#
# streamripper
#
STREAMRIPPER_VER    = git
STREAMRIPPER_DIR    = ni-streamripper.git
STREAMRIPPER_SOURCE = ni-streamripper.git
STREAMRIPPER_SITE   = https://github.com/neutrino-images

$(D)/streamripper: bootstrap libvorbisidec libmad glib2
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix= \
			--includedir=$(TARGET_INCLUDE_DIR) \
			--datarootdir=/.remove \
			--with-included-argv=yes \
			--with-included-libmad=no \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/streamripper.sh $(TARGET_DIR)/bin/
	$(PKG_REMOVE)
	$(TOUCH)
