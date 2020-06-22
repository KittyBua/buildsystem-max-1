#
# minidlna
#
MINIDLNA_VER    = 1.2.1
MINIDLNA_DIR    = minidlna-$(MINIDLNA_VER)
MINIDLNA_SOURCE = minidlna-$(MINIDLNA_VER).tar.gz
MINIDLNA_SITE   = https://sourceforge.net/projects/minidlna/files/minidlna/$(MINIDLNA_VER)

MINIDLNA_PATCH  = \
	0001-minidlna.patch

$(D)/minidlna: bootstrap zlib sqlite libexif libjpeg-turbo libid3tag libogg libvorbis flac ffmpeg
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--localedir=/.remove/locale \
			; \
		$(MAKE); \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
