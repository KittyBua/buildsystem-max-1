#
# libvorbisidec
#
LIBVORBISIDEC_VER    = 1.2.1+git20180316
LIBVORBISIDEC_DIR    = libvorbisidec-$(LIBVORBISIDEC_VER)
LIBVORBISIDEC_SOURCE = libvorbisidec_$(LIBVORBISIDEC_VER).orig.tar.gz
LIBVORBISIDEC_SITE   = https://ftp.de.debian.org/debian/pool/main/libv/libvorbisidec
LIBVORBISIDEC_DEPS   = bootstrap libogg

define LIBVORBISIDEC_POST_PATCH
	$(SED) '122 s/^/#/' $(PKG_BUILD_DIR)/configure.in
endef
LIBVORBISIDEC_POST_PATCH_HOOKS = LIBVORBISIDEC_POST_PATCH

$(D)/libvorbisidec:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi; \
		$(CONFIGURE) ; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
