################################################################################
#
# libaacs
#
################################################################################

LIBAACS_VERSION = 0.11.1
LIBAACS_DIR = libaacs-$(LIBAACS_VERSION)
LIBAACS_SOURCE = libaacs-$(LIBAACS_VERSION).tar.bz2
LIBAACS_SITE = https://download.videolan.org/pub/videolan/libaacs/$(LIBAACS_VERSION)

LIBAACS_DEPENDS = libgcrypt

LIBAACS_CONF_OPTS = \
	--disable-werror \
	--disable-extra-warnings \
	--disable-optimizations \
	--disable-examples \
	--disable-debug \
	--with-gnu-ld \
	--enable-shared \
	--disable-static

define LIBAACS_BOOTSTRAP
	$(CD) $(PKG_BUILD_DIR); \
		./bootstrap
endef
LIBAACS_PRE_CONFIGURE_HOOKS += LIBAACS_BOOTSTRAP

define LIBAACS_INSTALL_FILES
	$(INSTALL) -d $(TARGET_DIR)/.cache/aacs/vuk
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/KEYDB.cfg $(TARGET_DIR)/.config/aacs/KEYDB.cfg
endef
LIBAACS_POST_INSTALL_HOOKS += LIBAACS_INSTALL_FILES

$(D)/libaacs: | bootstrap
	$(call autotools-package)
