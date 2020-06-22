#
# alsa-lib
#
ALSA_LIB_VER    = 1.2.3
ALSA_LIB_DIR    = alsa-lib-$(ALSA_LIB_VER)
ALSA_LIB_SOURCE = alsa-lib-$(ALSA_LIB_VER).tar.bz2
ALSA_LIB_SITE   = https://www.alsa-project.org/files/pub/lib

ALSA_LIB_PATCH  = \
	0001-Don-t-use-fork-on-noMMU-platforms.patch \
	0002-alsa-lib.patch \
	0003-alsa-lib-link_fix.patch

$(D)/alsa-lib: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-alsa-devdir=/dev/snd/ \
			--with-plugindir=/usr/lib/alsa \
			--without-debug \
			--with-debug=no \
			--with-versioned=no \
			--enable-symbolic-functions \
			--enable-silent-rules \
			--disable-aload \
			--disable-rawmidi \
			--disable-resmgr \
			--disable-old-symbols \
			--disable-alisp \
			--disable-ucm \
			--disable-hwdep \
			--disable-python \
			--disable-topology \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
