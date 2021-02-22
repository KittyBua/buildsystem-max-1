#
# kmod
#
KMOD_VER    = 26
KMOD_DIR    = kmod-$(KMOD_VER)
KMOD_SOURCE = kmod-$(KMOD_VER).tar.xz
KMOD_SITE   = https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod
KMOD_DEPS   = bootstrap zlib

KMOD_AUTORECONF = YES

KMOD_CONF_OPTS = \
	--bindir=$(base_bindir) \
	--disable-static \
	--enable-shared \
	--disable-manpages \
	--without-zlib \
	--without-zstd

$(D)/kmod:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	for target in depmod insmod lsmod modinfo modprobe rmmod; do \
		ln -sfv ../bin/kmod $(TARGET_DIR)/sbin/$$target; \
	done
	mkdir -p $(TARGET_DIR)/lib/{depmod.d,modprobe.d}
	mkdir -p $(TARGET_DIR)/etc/{depmod.d,modprobe.d}
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
