################################################################################
#
# bzip2
#
################################################################################

BZIP2_VERSION = 1.0.8
BZIP2_DIR     = bzip2-$(BZIP2_VERSION)
BZIP2_SOURCE  = bzip2-$(BZIP2_VERSION).tar.gz
BZIP2_SITE    = https://sourceware.org/pub/bzip2
BZIP2_DEPENDS = bootstrap

define BZIP2_MAKEFILE_LIBBZ2_SO
	mv $(PKG_BUILD_DIR)/Makefile-libbz2_so $(PKG_BUILD_DIR)/Makefile
endef
BZIP2_POST_PATCH_HOOKS += BZIP2_MAKEFILE_LIBBZ2_SO

$(D)/bzip2:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE); \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	$(call TARGET_FOLLOWUP)
