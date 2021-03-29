#
# jfsutils
#
JFSUTILS_VERSION = 1.1.15
JFSUTILS_DIR     = jfsutils-$(JFSUTILS_VERSION)
JFSUTILS_SOURCE  = jfsutils-$(JFSUTILS_VERSION).tar.gz
JFSUTILS_SITE    = http://jfs.sourceforge.net/project/pub
JFSUTILS_DEPENDS = bootstrap e2fsprogs

define JFSUTILS_POST_PATCH
	$(SED) '/unistd.h/a#include <sys/types.h>' $(PKG_BUILD_DIR)/fscklog/extract.c
	$(SED) '/ioctl.h/a#include <sys/sysmacros.h>' $(PKG_BUILD_DIR)/libfs/devices.c
endef
JFSUTILS_POST_PATCH_HOOKS = JFSUTILS_POST_PATCH

jfsutils:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,jfs_debugfs jfs_fscklog jfs_logdump)
	$(TOUCH)
