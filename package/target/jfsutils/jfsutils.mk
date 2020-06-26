#
# jfsutils
#
JFSUTILS_VER    = 1.1.15
JFSUTILS_DIR    = jfsutils-$(JFSUTILS_VER)
JFSUTILS_SOURCE = jfsutils-$(JFSUTILS_VER).tar.gz
JFSUTILS_SITE   = http://jfs.sourceforge.net/project/pub

JFSUTILS_PATCH  = \
	0001-jfsutils.patch

$(D)/jfsutils: bootstrap e2fsprogs
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		sed -i "/unistd.h/a#include <sys/types.h>" fscklog/extract.c; \
		sed -i "/ioctl.h/a#include <sys/sysmacros.h>" libfs/devices.c; \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix= \
			--mandir=/.remove \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,jfs_debugfs jfs_fscklog jfs_logdump)
	$(PKG_REMOVE)
	$(TOUCH)
