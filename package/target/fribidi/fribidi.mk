#
# fribidi
#
FRIBIDI_VER    = 1.0.10
FRIBIDI_DIR    = fribidi-$(FRIBIDI_VER)
FRIBIDI_SOURCE = fribidi-$(FRIBIDI_VER).tar.xz
FRIBIDI_SITE   = https://github.com/fribidi/fribidi/releases/download/v$(FRIBIDI_VER)
FRIBIDI_DEPS   = bootstrap

FRIBIDI_CONF_OPTS = \
	--enable-shared \
	--enable-static \
	--disable-debug \
	--disable-deprecated

$(D)/fribidi:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	cd $(TARGET_DIR) && rm usr/bin/fribidi
	$(REMOVE)
	$(TOUCH)
