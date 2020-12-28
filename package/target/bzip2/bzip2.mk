#
# bzip2
#
BZIP2_VER    = 1.0.8
BZIP2_DIR    = bzip2-$(BZIP2_VER)
BZIP2_SOURCE = bzip2-$(BZIP2_VER).tar.gz
BZIP2_SITE   = https://sourceware.org/pub/bzip2

BZIP2_PATCH = \
	0001-bzip2.patch

$(D)/bzip2: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		mv Makefile-libbz2_so Makefile; \
		$(MAKE) CC=$(TARGET_CC) AR=$(TARGET_AR) RANLIB=$(TARGET_RANLIB); \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	$(PKG_REMOVE)
	$(TOUCH)
