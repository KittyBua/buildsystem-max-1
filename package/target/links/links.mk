################################################################################
#
# links
#
################################################################################

LINKS_VERSION = 2.25
LINKS_DIR = links-$(LINKS_VERSION)
LINKS_SOURCE = links-$(LINKS_VERSION).tar.bz2
LINKS_SITE = http://links.twibright.com/download

LINKS_DEPENDS = bootstrap freetype libpng libjpeg-turbo openssl zlib

LINKS_AUTORECONF = YES

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

ifeq ($(BOXMODEL),$(filter $(BOXMODEL),hd51 hd60 hd61 bre2ze4k))
define LINKS_PATCH_RCINPUT_C
	$(SED) 's|"/dev/input/event0"|"/dev/input/event1"|' $(PKG_BUILD_DIR)/rcinput.c
endef
else ifeq ($(BOXMODEL),$(filter $(BOXMODEL),h7))
define LINKS_PATCH_RCINPUT_C
	$(SED) 's|"/dev/input/event0"|"/dev/input/event2"|' $(PKG_BUILD_DIR)/rcinput.c
endef
endif
LINKS_POST_PATCH_HOOKS += LINKS_PATCH_RCINPUT_C

define LINKS_PREPARE_INTL
	$(SED) 's|^T_SAVE_HTML_OPTIONS,.*|T_SAVE_HTML_OPTIONS, "HTML-Optionen speichern",|' $(PKG_BUILD_DIR)/intl/german.lng
	echo "english" > $(PKG_BUILD_DIR)/intl/index.txt
	echo "german" >> $(PKG_BUILD_DIR)/intl/index.txt
	$(CHDIR)/$($(PKG)_DIR)/intl; \
		./gen-intl
endef
LINKS_POST_PATCH_HOOKS += LINKS_PREPARE_INTL

define LINKS_INSTALL_FILES
	mkdir -p $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins $(TARGET_DIR)/var/tuxbox/config/links
	mv $(TARGET_BIN_DIR)/links $(SHARE_NEUTRINO_PLUGINS)/links.so
	echo 'name=Links Web Browser'	 > $(SHARE_NEUTRINO_PLUGINS)/links.cfg
	echo 'desc=Web Browser'		>> $(SHARE_NEUTRINO_PLUGINS)/links.cfg
	echo 'type=2'			>> $(SHARE_NEUTRINO_PLUGINS)/links.cfg
	echo 'language "German"' 	 > $(VAR_NEUTRINO_CONFIG)/links/links.cfg
	echo 'bookmarkcount=0'		 > $(VAR_NEUTRINO_CONFIG)/bookmarks
	touch $(TARGET_DIR)/var/tuxbox/config/links/links.his
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/bookmarks.html  $(TARGET_DIR)/var/tuxbox/config/links/bookmarks.html
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/tables.tar.gz  $(TARGET_DIR)/var/tuxbox/config/links/tables.tar.gz
endef
LINKS_POST_INSTALL_HOOKS += LINKS_INSTALL_FILES

$(D)/links:
	$(call autotools-package)
