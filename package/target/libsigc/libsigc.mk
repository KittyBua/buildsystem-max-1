#
# libsigc
#
LIBSIGC_VER    = 2.10.2
LIBSIGC_DIR    = libsigc++-$(LIBSIGC_VER)
LIBSIGC_SOURCE = libsigc++-$(LIBSIGC_VER).tar.xz
LIBSIGC_SITE   = https://download.gnome.org/sources/libsigc++/$(basename $(LIBSIGC_VER))

$(D)/libsigc: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-benchmark \
			--disable-documentation \
			--disable-warnings \
			--without-boost \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
	if [ -d $(TARGET_INCLUDE_DIR)/sigc++-2.0/sigc++ ] ; then \
		ln -sf ./sigc++-2.0/sigc++ $(TARGET_INCLUDE_DIR)/sigc++; \
	fi;
	mv $(TARGET_LIB_DIR)/sigc++-2.0/include/sigc++config.h $(TARGET_INCLUDE_DIR); \
	rm -fr $(TARGET_LIB_DIR)/sigc++-2.0
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
