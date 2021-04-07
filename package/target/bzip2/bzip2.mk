#
# bzip2
#
BZIP2_VERSION = 1.0.8
BZIP2_DIR     = bzip2-$(BZIP2_VERSION)
BZIP2_SOURCE  = bzip2-$(BZIP2_VERSION).tar.gz
BZIP2_SITE    = https://sourceware.org/pub/bzip2
BZIP2_DEPENDS = bootstrap

$(D)/bzip2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		mv Makefile-libbz2_so Makefile; \
		$(MAKE) CC=$(TARGET_CC) AR=$(TARGET_AR) RANLIB=$(TARGET_RANLIB); \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)
	$(TOUCH)
