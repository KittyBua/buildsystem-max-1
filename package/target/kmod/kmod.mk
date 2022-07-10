################################################################################
#
# kmod
#
################################################################################

KMOD_VERSION = 29
KMOD_DIR = kmod-$(KMOD_VERSION)
KMOD_SOURCE = kmod-$(KMOD_VERSION).tar.xz
KMOD_SITE = https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod

KMOD_DEPENDS = zlib

KMOD_AUTORECONF = YES

KMOD_CONF_OPTS = \
	--bindir=$(base_bindir) \
	--disable-static \
	--enable-shared \
	--disable-manpages \
	--with-zlib

define KMOD_INSTALL_FILES
	mkdir -p $(TARGET_DIR)/lib/{depmod.d,modprobe.d}
	mkdir -p $(TARGET_DIR)/etc/{depmod.d,modprobe.d}
	for target in depmod insmod lsmod modinfo modprobe rmmod; do \
		ln -sfv ../bin/kmod $(TARGET_BASE_SBIN_DIR)/$$target; \
	done
endef
KMOD_POST_INSTALL_HOOKS += KMOD_INSTALL_FILES

$(D)/kmod: | bootstrap
	$(call autotools-package)
