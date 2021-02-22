#
# bzip2
#
BZIP2_VER    = 1.0.8
BZIP2_DIR    = bzip2-$(BZIP2_VER)
BZIP2_SOURCE = bzip2-$(BZIP2_VER).tar.gz
BZIP2_SITE   = https://sourceware.org/pub/bzip2
BZIP2_DEPS   = bootstrap

$(D)/bzip2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		mv Makefile-libbz2_so Makefile; \
		$(MAKE) CC=$(TARGET_CC) AR=$(TARGET_AR) RANLIB=$(TARGET_RANLIB); \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)
	$(TOUCH)
