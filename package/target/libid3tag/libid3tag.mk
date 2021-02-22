#
# libid3tag
#
LIBID3TAG_VER    = 0.15.1b
LIBID3TAG_DIR    = libid3tag-$(LIBID3TAG_VER)
LIBID3TAG_SOURCE = libid3tag-$(LIBID3TAG_VER).tar.gz
LIBID3TAG_SITE   = https://sourceforge.net/projects/mad/files/libid3tag/$(LIBID3TAG_VER)
LIBID3TAG_DEPS   = bootstrap zlib

LIBID3TAG_AUTORECONF = YES

$(D)/libid3tag:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared=yes \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
