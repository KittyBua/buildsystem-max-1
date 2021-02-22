#
# libsigc
#
LIBSIGC_VER    = 2.10.2
LIBSIGC_DIR    = libsigc++-$(LIBSIGC_VER)
LIBSIGC_SOURCE = libsigc++-$(LIBSIGC_VER).tar.xz
LIBSIGC_SITE   = https://download.gnome.org/sources/libsigc++/$(basename $(LIBSIGC_VER))
LIBSIGC_DEPS   = bootstrap

LIBSIGC_CONF_OPTS = \
	--enable-shared \
	--disable-benchmark \
	--disable-documentation \
	--disable-warnings \
	--without-boost

$(D)/libsigc:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	if [ -d $(TARGET_INCLUDE_DIR)/sigc++-2.0/sigc++ ] ; then \
		ln -sf ./sigc++-2.0/sigc++ $(TARGET_INCLUDE_DIR)/sigc++; \
	fi
	mv $(TARGET_LIB_DIR)/sigc++-2.0/include/sigc++config.h $(TARGET_INCLUDE_DIR)
	rm -fr $(TARGET_LIB_DIR)/sigc++-2.0
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
