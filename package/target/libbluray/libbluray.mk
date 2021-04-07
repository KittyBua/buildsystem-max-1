#
# libbluray
#
LIBBLURAY_VERSION = 0.9.3
LIBBLURAY_DIR     = libbluray-$(LIBBLURAY_VERSION)
LIBBLURAY_SOURCE  = libbluray-$(LIBBLURAY_VERSION).tar.bz2
LIBBLURAY_SITE    = ftp.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VERSION)
LIBBLURAY_DEPENDS = bootstrap

LIBBLURAY_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-extra-warnings \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--disable-examples \
	--disable-bdjava \
	--without-libxml2 \
	--without-fontconfig

$(D)/libbluray:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
