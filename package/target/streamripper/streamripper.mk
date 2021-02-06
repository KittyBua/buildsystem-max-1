#
# streamripper
#
STREAMRIPPER_VER    = git
STREAMRIPPER_DIR    = ni-streamripper.git
STREAMRIPPER_SOURCE = ni-streamripper.git
STREAMRIPPER_SITE   = https://github.com/neutrino-images
STREAMRIPPER_DEPS   = bootstrap libvorbisidec libmad glib2

STREAMRIPPER_AUTORECONF = YES

STREAMRIPPER_CONF_OPTS = \
	--with-ogg-includes=${TARGET_INCLUDE_DIR} \
	--with-ogg-libraries=${TARGET_LIB_DIR} \
	--with-vorbis-includes=${TARGET_INCLUDE_DIR} \
	--with-vorbis-libraries=${TARGET_LIB_DIR} \
	--with-included-argv=yes \
	--with-included-libmad=no

$(D)/streamripper:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/streamripper.sh $(TARGET_DIR)/bin/
	$(PKG_REMOVE)
	$(TOUCH)
