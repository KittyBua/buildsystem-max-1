#
# harfbuzz
#
HARFBUZZ_VER    = 1.8.8
HARFBUZZ_DIR    = harfbuzz-$(HARFBUZZ_VER)
HARFBUZZ_SOURCE = harfbuzz-$(HARFBUZZ_VER).tar.bz2
HARFBUZZ_SITE   = https://www.freedesktop.org/software/harfbuzz/release
HARFBUZZ_DEPS   = bootstrap glib2 cairo freetype

HARFBUZZ_CONF_OPTS = \
	--with-cairo \
	--with-freetype \
	--without-fontconfig \
	--with-glib \
	--without-graphite2 \
	--without-icu

$(D)/harfbuzz:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
