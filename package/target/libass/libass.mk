#
# libass
#
LIBASS_VER    = 0.14.0
LIBASS_DIR    = libass-$(LIBASS_VER)
LIBASS_SOURCE = libass-$(LIBASS_VER).tar.xz
LIBASS_SITE   = https://github.com/libass/libass/releases/download/$(LIBASS_VER)
LIBASS_DEPS   = bootstrap freetype fribidi

LIBASS_CONF_OPTS = \
	--disable-static \
	--disable-test \
	--disable-fontconfig \
	--disable-harfbuzz \
	--disable-require-system-font-provider

$(D)/libass:
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
