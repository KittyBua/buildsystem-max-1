#
# libid3tag
#
LIBID3TAG_VER    = 0.15.1b
LIBID3TAG_DIR    = libid3tag-$(LIBID3TAG_VER)
LIBID3TAG_SOURCE = libid3tag-$(LIBID3TAG_VER).tar.gz
LIBID3TAG_SITE   = https://sourceforge.net/projects/mad/files/libid3tag/$(LIBID3TAG_VER)

LIBID3TAG_PATCH  = \
	0001-addpkgconfig.patch \
	0002-obsolete_automake_macros.patch \
	0003-utf16.patch \
	0004-unknown-encoding.patch \
	0005-Fix-gperf-3.1-incompatibility.patch

$(D)/libid3tag: bootstrap zlib
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		touch NEWS AUTHORS ChangeLog; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared=yes \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
