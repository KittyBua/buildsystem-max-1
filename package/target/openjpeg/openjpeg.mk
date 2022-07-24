################################################################################
#
# openjpeg
#
################################################################################

OPENJPEG_VERSION = 2.4.0
OPENJPEG_DIR = openjpeg-$(OPENJPEG_VERSION)
OPENJPEG_SOURCE = openjpeg-$(OPENJPEG_VERSION).tar.gz
OPENJPEG_SITE = $(call github,uclouvain,openjpeg,v$(OPENJPEG_VERSION))

OPENJPEG_DEPENDS = zlib libpng

define OPENJPEG_TARGET_CLEANUP
	rm -rf $(addprefix $(TARGET_LIB_DIR)/,openjpeg-$(basename $(OPENJPEG_VERSION)))
endef
OPENJPEG_TARGET_CLEANUP_HOOKS += OPENJPEG_TARGET_CLEANUP

$(D)/openjpeg: | bootstrap
	$(call cmake-package)
