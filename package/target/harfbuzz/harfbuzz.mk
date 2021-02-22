#
# harfbuzz
#
HARFBUZZ_VER    = 1.8.8
HARFBUZZ_DIR    = harfbuzz-$(HARFBUZZ_VER)
HARFBUZZ_SOURCE = harfbuzz-$(HARFBUZZ_VER).tar.bz2
HARFBUZZ_SITE   = https://www.freedesktop.org/software/harfbuzz/release
HARFBUZZ_DEPS   = bootstrap glib2 cairo freetype

HARFBUZZ_AUTORECONF = YES

HARFBUZZ_CONF_OPTS = \
	--with-cairo \
	--with-freetype \
	--without-fontconfig \
	--with-glib \
	--without-graphite2 \
	--without-icu

$(D)/harfbuzz:
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
	$(REMOVE)
	$(TOUCH)
