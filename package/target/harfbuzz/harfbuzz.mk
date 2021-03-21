#
# harfbuzz
#
HARFBUZZ_VERSION = 1.8.8
HARFBUZZ_DIR     = harfbuzz-$(HARFBUZZ_VERSION)
HARFBUZZ_SOURCE  = harfbuzz-$(HARFBUZZ_VERSION).tar.bz2
HARFBUZZ_SITE    = https://www.freedesktop.org/software/harfbuzz/release
HARFBUZZ_DEPENDS = bootstrap glib2 cairo freetype

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
