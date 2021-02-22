#
# util-linux
#
UTIL_LINUX_VER    = 2.36.2
UTIL_LINUX_DIR    = util-linux-$(UTIL_LINUX_VER)
UTIL_LINUX_SOURCE = util-linux-$(UTIL_LINUX_VER).tar.xz
#UTIL_LINUX_SITE   = https://www.kernel.org/pub/linux/utils/util-linux/v$(UTIL_LINUX_VER)
UTIL_LINUX_SITE   = https://www.kernel.org/pub/linux/utils/util-linux/v$(basename $(UTIL_LINUX_VER))
UTIL_LINUX_DEPS   = bootstrap zlib

UTIL_LINUX_CONF_OPTS = \
	--bindir=$(base_bindir) \
	--sbindir=$(base_sbindir) \
	--docdir=$(REMOVE_docdir) \
	--disable-gtk-doc \
	\
	--disable-agetty \
	--disable-bash-completion \
	--disable-bfs \
	--disable-cal \
	--disable-chfn-chsh \
	--disable-chmem \
	--disable-cramfs \
	--disable-eject \
	--disable-fallocate \
	--disable-fdformat \
	--disable-hardlink \
	--disable-hwclock \
	--disable-ipcrm \
	--disable-ipcs \
	--disable-kill \
	--disable-last \
	--enable-libblkid \
	--enable-libfdisk \
	--enable-libmount \
	--enable-libsmartcols \
	--enable-libuuid \
	--disable-line \
	--disable-logger \
	--disable-login \
	--disable-losetup \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-lsirq \
	--disable-lslogins \
	--disable-lsmem \
	--disable-makeinstall-chown \
	--disable-makeinstall-setuid \
	--disable-makeinstall-chown \
	--disable-mesg \
	--disable-minix \
	--disable-more \
	--disable-mountpoint \
	--disable-newgrp \
	--disable-nls \
	--disable-nologin \
	--disable-nsenter \
	--disable-partx \
	--disable-pg \
	--disable-pg-bell \
	--disable-pivot_root \
	--disable-pylibmount \
	--disable-raw \
	--disable-rename \
	--disable-rfkill \
	--disable-runuser \
	--disable-rpath \
	--disable-schedutils \
	--disable-setpriv \
	--disable-setterm \
	--disable-su \
	--enable-sulogin \
	--disable-switch_root \
	--disable-tunelp \
	--disable-ul \
	--disable-unshare \
	--disable-use-tty-group \
	--disable-utmpdump \
	--disable-vipw \
	--disable-wall \
	--disable-wdctl \
	--disable-write \
	--disable-zramctl \
	\
	--without-audit \
	--without-cap-ng \
	--without-btrfs \
	--without-ncurses \
	--without-ncursesw \
	--without-python \
	--without-readline \
	--without-slang \
	--without-smack \
	--without-libmagic \
	--without-systemd \
	--without-systemdsystemunitdir \
	--without-tinfo \
	--without-udev \
	--without-utempter

$(D)/util-linux:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/bin/,findmnt mount umount)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,blkdiscard blkzone blockdev cfdisk chcpu ctrlaltdel fsfreeze fstrim mkfs mkswap swaplabel wipefs)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,choom col colcrt colrm column fincore flock getopt ipcmk isosize linux32 linux64 look lscpu lsipc lslocks lsns mcookie namei prlimit renice rev script scriptlive scriptreplay setarch setsid uname26 uuidgen uuidparse whereis)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,ldattach readprofile rtcwake)
	$(INSTALL) -d $(TARGET_DIR)/etc/default/
	echo 'MOUNTALL="-t nonfs,nosmbfs,noncpfs"' > $(TARGET_DIR)/etc/default/mountall
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
