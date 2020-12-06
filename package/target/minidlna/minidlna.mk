#
# minidlna
#
MINIDLNA_VER    = 1.3.0
MINIDLNA_DIR    = minidlna-$(MINIDLNA_VER)
MINIDLNA_SOURCE = minidlna-$(MINIDLNA_VER).tar.gz
MINIDLNA_SITE   = https://sourceforge.net/projects/minidlna/files/minidlna/$(MINIDLNA_VER)

MINIDLNA_PATCH  =

$(D)/minidlna: bootstrap zlib sqlite libexif libjpeg-turbo libid3tag libogg libvorbis flac ffmpeg
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-static \
			--localedir=/.remove/locale \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) -D $(PKG_BUILD_DIR)/minidlna.conf $(TARGET_DIR)/etc/minidlna.conf
	$(PKG_REMOVE)
	$(TOUCH)
