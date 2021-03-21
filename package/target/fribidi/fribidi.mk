#
# fribidi
#
FRIBIDI_VERSION = 1.0.10
FRIBIDI_DIR     = fribidi-$(FRIBIDI_VERSION)
FRIBIDI_SOURCE  = fribidi-$(FRIBIDI_VERSION).tar.xz
FRIBIDI_SITE    = https://github.com/fribidi/fribidi/releases/download/v$(FRIBIDI_VERSION)
FRIBIDI_DEPENDS = bootstrap

FRIBIDI_CONF_OPTS = \
	--enable-shared \
	--enable-static \
	--disable-debug \
	--disable-deprecated

$(D)/fribidi:
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
	cd $(TARGET_DIR) && rm usr/bin/fribidi
	$(REMOVE)
	$(TOUCH)
