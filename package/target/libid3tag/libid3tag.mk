#
# libid3tag
#
LIBID3TAG_VER    = 0.15.1b
LIBID3TAG_DIR    = libid3tag-$(LIBID3TAG_VER)
LIBID3TAG_SOURCE = libid3tag-$(LIBID3TAG_VER).tar.gz
LIBID3TAG_URL    = https://sourceforge.net/projects/mad/files/libid3tag/$(LIBID3TAG_VER)

LIBID3TAG_PATCH  = \
	0001-addpkgconfig.patch \
	0002-obsolete_automake_macros.patch \
	0003-utf16.patch \
	0004-unknown-encoding.patch \
	0005-Fix-gperf-3.1-incompatibility.patch

$(D)/libid3tag: bootstrap zlib
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
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
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
