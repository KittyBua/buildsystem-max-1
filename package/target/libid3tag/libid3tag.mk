#
# libid3tag
#
LIBID3TAG_VERSION = 0.15.1b
LIBID3TAG_DIR     = libid3tag-$(LIBID3TAG_VERSION)
LIBID3TAG_SOURCE  = libid3tag-$(LIBID3TAG_VERSION).tar.gz
LIBID3TAG_SITE    = https://sourceforge.net/projects/mad/files/libid3tag/$(LIBID3TAG_VERSION)
LIBID3TAG_DEPENDS = bootstrap zlib

LIBID3TAG_AUTORECONF = YES

$(D)/libid3tag:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared=yes \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
