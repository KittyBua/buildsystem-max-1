#
# kmod
#
KMOD_VER    = 26
KMOD_DIR    = kmod-$(KMOD_VER)
KMOD_SOURCE = kmod-$(KMOD_VER).tar.xz
KMOD_SITE   = https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod

KMOD_PATCH  = \
	0001-fix-O_CLOEXEC.patch \
	0002-avoid_parallel_tests.patch \
	0003-libkmod_pc_in.patch

$(D)/kmod: bootstrap zlib
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--bindir=/bin \
			--disable-static \
			--enable-shared \
			--disable-manpages \
			--sysconfdir=/etc \
			--with-zlib \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	for target in depmod insmod lsmod modinfo modprobe rmmod; do \
		ln -sfv ../bin/kmod $(TARGET_DIR)/sbin/$$target; \
	done
	mkdir -p $(TARGET_DIR)/lib/{depmod.d,modprobe.d}
	mkdir -p $(TARGET_DIR)/etc/{depmod.d,modprobe.d}
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
