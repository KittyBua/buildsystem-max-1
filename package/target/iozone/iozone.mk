################################################################################
#
# iozone
#
################################################################################

IOZONE_VERSION = 3_493
IOZONE_DIR = iozone$(IOZONE_VERSION)
IOZONE_SOURCE = iozone$(IOZONE_VERSION).tgz
IOZONE_SITE = http://www.iozone.org/src/current

IOZONE_DEPENDS = bootstrap

IOZONE_SUBDIR = src/current

define IOZONE_PATCH_MAKEFILE
	$(SED) "s/= gcc/= $(TARGET_CC)/" $(PKG_BUILD_DIR)/src/current/makefile
	$(SED) "s/= cc/= $(TARGET_CC)/" $(PKG_BUILD_DIR)/src/current/makefile
endef
IOZONE_POST_PATCH_HOOKS += IOZONE_PATCH_MAKEFILE

IOZONE_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV)

IOZONE_MAKE_OPTS = \
	linux-arm

define IOZONE_INSTALL_BINARY
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/src/current/iozone $(TARGET_BIN_DIR)
endef
IOZONE_POST_FOLLOWUP_HOOKS += IOZONE_INSTALL_BINARY

$(D)/iozone:
	$(call make-package,$(PKG_NO_INSTALL))
