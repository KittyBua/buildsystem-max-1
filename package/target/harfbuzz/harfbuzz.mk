################################################################################
#
# harfbuzz
#
################################################################################

HARFBUZZ_VERSION = 1.8.8
HARFBUZZ_DIR     = harfbuzz-$(HARFBUZZ_VERSION)
HARFBUZZ_SOURCE  = harfbuzz-$(HARFBUZZ_VERSION).tar.bz2
HARFBUZZ_SITE    = https://www.freedesktop.org/software/harfbuzz/release
HARFBUZZ_DEPENDS = bootstrap glib2 cairo freetype

HARFBUZZ_AUTORECONF = YES

HARFBUZZ_CONF_OPTS = \
	--with-cairo \
	--without-fontconfig \
	--with-freetype \
	--with-glib \
	--without-graphite2 \
	--without-icu

$(D)/harfbuzz:
	$(call make-package)
