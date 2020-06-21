#
# libvorbisidec
#
LIBVORBISIDEC_VER    = 1.2.1+git20180316
LIBVORBISIDEC_DIR    = libvorbisidec-$(LIBVORBISIDEC_VER)
LIBVORBISIDEC_SOURCE = libvorbisidec_$(LIBVORBISIDEC_VER).orig.tar.gz
LIBVORBISIDEC_SITE   = https://ftp.de.debian.org/debian/pool/main/libv/libvorbisidec

$(D)/libvorbisidec: bootstrap libogg
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		ACLOCAL_FLAGS="-I . -I $(TARGET_DIR)/usr/share/aclocal" \
		$(BUILD_ENV) \
		./autogen.sh $(SILENT_OPT) \
			--host=$(TARGET) \
			--build=$(BUILD) \
			--prefix=/usr \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
