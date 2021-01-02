#
# e2fsprogs
#
E2FSPROGS_VER    = 1.45.6
E2FSPROGS_DIR    = e2fsprogs-$(E2FSPROGS_VER)
E2FSPROGS_SOURCE = e2fsprogs-$(E2FSPROGS_VER).tar.gz
E2FSPROGS_SITE   = https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v$(E2FSPROGS_VER)

E2FSPROGS_CONF_OPTS = \
	LIBS="-luuid -lblkid" \
	ac_cv_path_LDCONFIG=true \
	--sbindir=$(base_sbindir) \
	--disable-backtrace \
	--disable-blkid-debug \
	--disable-bmap-stats \
	--disable-debugfs \
	--disable-defrag \
	--disable-e2initrd-helper \
	--disable-fuse2fs \
	--disable-imager \
	--disable-jbd-debug \
	--disable-mmp \
	--disable-nls \
	--disable-rpath \
	--disable-testio-debug \
	--disable-tdb \
	--enable-elf-shlibs \
	--enable-fsck \
	--disable-libblkid \
	--disable-libuuid \
	--disable-uuidd \
	--enable-verbose-makecmds \
	--enable-symlink-install \
	--without-libintl-prefix \
	--without-libiconv-prefix \
	--with-root-prefix="" \
	--with-crond-dir=no

$(D)/e2fsprogs: bootstrap util-linux
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		PATH=$(BUILD_DIR)/e2fsprogs-$(E2FSPROGS_VER):$(PATH) \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,badblocks dumpe2fs e2freefrag e2mmpstatus e2undo e4crypt filefrag logsave mklost+found)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,mk_cmds uuidd)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,chattr compile_et mk_cmds lsattr uuidgen)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,et ss)
	$(PKG_REMOVE)
	$(TOUCH)
