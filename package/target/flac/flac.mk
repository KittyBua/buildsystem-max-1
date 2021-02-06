#
# flac
#
FLAC_VER    = 1.3.3
FLAC_DIR    = flac-$(FLAC_VER)
FLAC_SOURCE = flac-$(FLAC_VER).tar.xz
FLAC_SITE   = https://ftp.osuosl.org/pub/xiph/releases/flac
FLAC_DEPS   = bootstrap

FLAC_AUTORECONF = YES

FLAC_CONF_OPTS = \
	--disable-cpplibs \
	--disable-debug \
	--disable-asm-optimizations \
	--disable-sse \
	--disable-altivec \
	--disable-doxygen-docs \
	--disable-thorough-tests \
	--disable-exhaustive-tests \
	--disable-valgrind-testing \
	--disable-ogg \
	--disable-oggtest \
	--disable-local-xmms-plugin \
	--disable-xmms-plugin \
	--disable-examples \
	--disable-rpath

$(D)/flac:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
