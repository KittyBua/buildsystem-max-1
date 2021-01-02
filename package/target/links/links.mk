#
# links
#
LINKS_VER    = 2.21
LINKS_DIR    = links-$(LINKS_VER)
LINKS_SOURCE = links-$(LINKS_VER).tar.bz2
LINKS_SITE   = http://links.twibright.com/download

ifeq ($(BOXMODEL),$(filter $(BOXMODEL),hd51 hd60 hd61 bre2ze4k))
LINKS_CUSTOM_PATCH += 0004-links-input-event1.patch
else ifeq ($(BOXMODEL),$(filter $(BOXMODEL),h7))
LINKS_CUSTOM_PATCH += 0005-links-input-event2.patch
endif

define LINKS_CUSTOM_PATCHES
	$(APPLY_PATCHES) $(PKG_BUILD_DIR) $(PKG_PATCHES_DIR)/custom \$(LINKS_CUSTOM_PATCH)
endef
LINKS_POST_PATCH_HOOKS += LINKS_CUSTOM_PATCHES

define LINKS_POST_PATCH
	$(SED) 's|^T_SAVE_HTML_OPTIONS,.*|T_SAVE_HTML_OPTIONS, "HTML-Optionen speichern",|' $(PKG_BUILD_DIR)/intl/german.lng
endef
LINKS_POST_PATCH_HOOKS += LINKS_POST_PATCH

LINKS_CONF_OPTS = \
	--with-libjpeg \
	--without-libtiff \
	--without-svgalib \
	--without-lzma \
	--with-fb \
	--without-directfb \
	--without-pmshell \
	--without-atheos \
	--enable-graphics \
	--with-ssl=$(TARGET_DIR)/usr \
	--without-x

$(D)/links: bootstrap freetype libpng libjpeg-turbo openssl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR)/intl; \
		echo "english" > index.txt; \
		echo "german" >> index.txt; \
		./gen-intl
	$(CHDIR)/$(PKG_DIR); \
		autoreconf -vfi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins $(TARGET_DIR)/var/tuxbox/config/links
	mv $(TARGET_DIR)/usr/bin/links $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/links.so
	echo 'name=Links Web Browser'	 > $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/links.cfg
	echo 'desc=Web Browser'		>> $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/links.cfg
	echo 'type=2'			>> $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/links.cfg
	echo 'language "German"' 	 > $(TARGET_DIR)/var/tuxbox/config/links/links.cfg
	echo 'bookmarkcount=0'		 > $(TARGET_DIR)/var/tuxbox/config/bookmarks
	touch $(TARGET_DIR)/var/tuxbox/config/links/links.his
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/bookmarks.html  $(TARGET_DIR)/var/tuxbox/config/links/bookmarks.html
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/tables.tar.gz  $(TARGET_DIR)/var/tuxbox/config/links/tables.tar.gz
	$(PKG_REMOVE)
	$(TOUCH)
