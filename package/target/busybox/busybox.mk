#
# busybox
#
BUSYBOX_VER    = 1.32.0
BUSYBOX_DIR    = busybox-$(BUSYBOX_VER)
BUSYBOX_SOURCE = busybox-$(BUSYBOX_VER).tar.bz2
BUSYBOX_SITE   = https://busybox.net/downloads

BUSYBOX_PATCH = \
	0001-Prevent-telnet-connections-from-the-internet-to-the.patch \
	0002-Extended-network-interfaces-support.patch \
	0003-Revert-ip-fix-ip-oneline-a.patch \
	0004-use_ipv6_when_ipv4_unroutable.patch \
	0005-fix-config-header.patch \
	0006-fix-partition-size.patch \
	0007-insmod-hack.patch \
	0008-mount_single_uuid.patch \
	0009-busybox-udhcpc-no_deconfig.patch \
	0010-recognize_connmand.patch \
	0011-fail_on_no_media.patch \
	0012-busybox-cross-menuconfig.patch \
	0013-makefile-libbb-race.patch \
	0014-testsuite-check-uudecode-before-using-it.patch \
	0015-testsuite-use-www.example.org-for-wget-test-cases.patch \
	0016-du-l-works-fix-to-use-145-instead-of-144.patch \
	0017-Use-CC-when-linking-instead-of-LD-and-use-CFLAGS-and.patch \
	0018-sysctl-ignore-EIO-of-stable_secret-below-proc-sys-ne.patch \
	0019-hwclock-make-glibc-2.31-compatible.patch

# Link busybox against libtirpc so that we can leverage its RPC support for NFS
# mounting with BusyBox
BUSYBOX_CFLAGS = $(TARGET_CFLAGS)
BUSYBOX_CFLAGS += "`$(PKG_CONFIG) --cflags libtirpc`"

# Don't use LDFLAGS for -ltirpc, because LDFLAGS is used for the non-final link
# of modules as well.
BUSYBOX_CFLAGS_busybox = "`$(PKG_CONFIG) --libs libtirpc`"

# Allows the buildsystem to tweak CFLAGS
BUSYBOX_MAKE_ENV = \
	CFLAGS="$(BUSYBOX_CFLAGS)" \
	CFLAGS_busybox="$(BUSYBOX_CFLAGS_busybox)"

BUSYBOX_MAKE_OPTS = \
	$(MAKE_OPTS) \
	EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
	EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
	CONFIG_PREFIX="$(TARGET_DIR)"

$(D)/busybox: bootstrap libtirpc
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(INSTALL_DATA) $(PKG_FILES_DIR)/busybox.config .config; \
		sed -i -e 's#^CONFIG_PREFIX.*#CONFIG_PREFIX="$(TARGET_DIR)"#' .config; \
		$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) busybox; \
		$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) install-noclobber
	@if grep -q "CONFIG_CROND=y" $(BUILD_DIR)/$(BUSYBOX_DIR)/.config; then \
		mkdir -p $(TARGET_DIR)/etc/cron/crontabs; \
		$(INSTALL_EXEC) $(PKG_FILES_DIR)/cron.busybox $(TARGET_DIR)/etc/init.d/cron.busybox; \
		$(UPDATE-RC.D) cron.busybox start 90 2 3 4 5 . stop 60 0 1 6 .; \
	fi
	@if grep -q "CONFIG_INETD=y" $(BUILD_DIR)/$(BUSYBOX_DIR)/.config; then \
		$(INSTALL_DATA) $(PKG_FILES_DIR)/inetd.conf $(TARGET_DIR)/etc/inetd.conf; \
		$(INSTALL_EXEC) $(PKG_FILES_DIR)/inetd.busybox $(TARGET_DIR)/etc/init.d/inetd.busybox; \
	fi
	@if grep -q "CONFIG_MDEV=y" $(BUILD_DIR)/$(BUSYBOX_DIR)/.config; then \
		$(INSTALL_DATA) $(PKG_FILES_DIR)/mdev.conf $(TARGET_DIR)/etc/mdev.conf; \
	fi
	@if grep -q "CONFIG_SYSLOGD=y" $(BUILD_DIR)/$(BUSYBOX_DIR)/.config; then \
		$(INSTALL_DATA) $(PKG_FILES_DIR)/syslog-startup.conf $(TARGET_DIR)/etc/syslog-startup.conf; \
		$(INSTALL_EXEC) $(PKG_FILES_DIR)/syslog.busybox $(TARGET_DIR)/etc/init.d/syslog.busybox; \
		$(UPDATE-RC.D) syslog.busybox start 20 2 3 4 5 . stop 20 0 1 6 .; \
	fi
	@if grep -q "CONFIG_FEATURE_TELNETD_STANDALONE=y" $(BUILD_DIR)/$(BUSYBOX_DIR)/.config; then \
		$(INSTALL_EXEC) $(PKG_FILES_DIR)/telnetd.busybox $(TARGET_DIR)/etc/init.d/telnetd.busybox; \
		$(UPDATE-RC.D) telnetd.busybox start 20 2 3 4 5 . stop 20 0 1 6 .; \
	fi
	@if grep -q "CONFIG_UDHCPC=y" $(BUILD_DIR)/$(BUSYBOX_DIR)/.config; then \
		mkdir -p $(TARGET_DIR)/etc/udhcpc.d; \
		$(INSTALL_EXEC) $(PKG_FILES_DIR)/55ntp $(TARGET_DIR)/etc/udhcpc.d/55ntp; \
		$(INSTALL_EXEC) $(PKG_FILES_DIR)/50default $(TARGET_DIR)/etc/udhcpc.d/50default; \
		$(INSTALL_EXEC) -D $(PKG_FILES_DIR)/default.script $(TARGET_SHARE_DIR)/udhcpc/default.script; \
	fi
#	$(UPDATE-RC.D) inetd.busybox start 20 2 3 4 5 . stop 20 0 1 6 .
	$(PKG_REMOVE)
	$(TOUCH)

busybox-config: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(INSTALL_DATA) $(subst -config,,$(PKG_FILES_DIR))/busybox.config .config; \
		make menuconfig
