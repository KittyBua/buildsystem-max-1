#
# samba
#
SAMBA_VER    = 3.6.25
SAMBA_DIR    = samba-$(SAMBA_VER)
SAMBA_SOURCE = samba-$(SAMBA_VER).tar.gz
SAMBA_SITE   = https://ftp.samba.org/pub/samba/stable

SAMBA_PATCH = \
	010-patch-cve-2015-5252.patch \
	011-patch-cve-2015-5296.patch \
	012-patch-cve-2015-5299.patch \
	015-patch-cve-2015-7560.patch \
	020-CVE-preparation-v3-6.patch \
	021-CVE-preparation-v3-6-addition.patch \
	022-CVE-2015-5370-v3-6.patch \
	023-CVE-2016-2110-v3-6.patch \
	024-CVE-2016-2111-v3-6.patch \
	025-CVE-2016-2112-v3-6.patch \
	026-CVE-2016-2115-v3-6.patch \
	027-CVE-2016-2118-v3-6.patch \
	028-CVE-2017-7494-v3-6.patch \
	100-configure_fixes.patch \
	110-multicall.patch \
	111-owrt_smbpasswd.patch \
	120-add_missing_ifdef.patch \
	200-remove_printer_support.patch \
	210-remove_ad_support.patch \
	220-remove_services.patch \
	230-remove_winreg_support.patch \
	240-remove_dfs_api.patch \
	250-remove_domain_logon.patch \
	260-remove_samr.patch \
	270-remove_registry_backend.patch \
	280-strip_srvsvc.patch \
	290-remove_lsa.patch \
	300-assert_debug_level.patch \
	310-remove_error_strings.patch \
	320-debug_level_checks.patch \
	330-librpc_default_print.patch \
	samba-3.6.25.patch

SAMBA_CONF_OPTS = \
	--disable-pie \
	--disable-avahi \
	--disable-cups \
	--disable-relro \
	--disable-static \
	--disable-shared-libs \
	--enable-shared \
	--disable-swat \
	--disable-socket-wrapper \
	--disable-nss-wrapper \
	--disable-smbtorture4 \
	--disable-fam \
	--disable-iprint \
	--disable-dnssd \
	--disable-pthreadpool \
	--disable-dmalloc \
	--with-configdir=/etc/samba \
	--with-privatedir=/etc/samba/private \
	--with-mandir=no \
	--with-codepagedir=/etc/samba \
	--with-piddir=/var/run \
	--with-lockdir=/var/lock \
	--with-logfilebase=/var/log/samba \
	--with-swatdir=/usr/share/swat \
	--with-nmbdsocketdir=/var/run/nmbd \
	--with-included-iniparser \
	--with-included-popt \
	--with-sendfile-support \
	--without-aio-support \
	--without-cluster-support \
	--without-ads \
	--without-krb5 \
	--without-dnsupdate \
	--without-automount \
	--without-ldap \
	--without-pam \
	--without-pam_smbpass \
	--without-winbind \
	--without-wbclient \
	--without-syslog \
	--without-nisplus-home \
	--without-quotas \
	--without-sys-quotas \
	--without-utmp \
	--without-acl-support \
	--disable-cups \
	--without-winbind \
	--without-libtdb \
	--without-libtalloc \
	--without-libnetapi \
	--without-libsmbclient \
	--without-libsmbsharemodes \
	--without-libtevent \
	--without-libaddns

$(D)/samba: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		cd source3; \
		./autogen.sh $(SILENT_OPT); \
		$(BUILD_ENV) \
		ac_cv_lib_attr_getxattr=no \
		ac_cv_search_getxattr=no \
		ac_cv_file__proc_sys_kernel_core_pattern=yes \
		libreplace_cv_HAVE_C99_VSNPRINTF=yes \
		libreplace_cv_HAVE_GETADDRINFO=yes \
		libreplace_cv_HAVE_IFACE_IFCONF=yes \
		LINUX_LFS_SUPPORT=no \
		samba_cv_CC_NEGATIVE_ENUM_VALUES=yes \
		samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
		samba_cv_HAVE_IFACE_IFCONF=yes \
		samba_cv_HAVE_KERNEL_OPLOCKS_LINUX=yes \
		samba_cv_HAVE_SECURE_MKSTEMP=yes \
		libreplace_cv_HAVE_SECURE_MKSTEMP=yes \
		samba_cv_HAVE_WRFILE_KEYTAB=no \
		samba_cv_USE_SETREUID=yes \
		samba_cv_USE_SETRESUID=yes \
		samba_cv_have_setreuid=yes \
		samba_cv_have_setresuid=yes \
		samba_cv_optimize_out_funcation_calls=no \
		ac_cv_header_zlib_h=no \
		samba_cv_zlib_1_2_3=no \
		ac_cv_path_PYTHON="" \
		ac_cv_path_PYTHON_CONFIG="" \
		libreplace_cv_HAVE_GETADDRINFO=no \
		libreplace_cv_READDIR_NEEDED=no \
		./configure $(CONFIGURE_OPTS) $(CONFIGURE_TARGET_OPTS); \
		$(MAKE); \
		$(MAKE) installservers \
			SBIN_PROGS="bin/samba_multicall" DESTDIR=$(TARGET_DIR) LOCALEDIR=$(REMOVE_localedir)
			ln -sf samba_multicall $(TARGET_DIR)/usr/sbin/nmbd
			ln -sf samba_multicall $(TARGET_DIR)/usr/sbin/smbd
			ln -sf samba_multicall $(TARGET_DIR)/usr/sbin/smbpasswd
	$(INSTALL_DATA) $(PKG_FILES_DIR)/smb.conf $(TARGET_DIR)/etc/samba/smb.conf
	$(INSTALL_DATA) $(PKG_FILES_DIR)/smbpasswd $(TARGET_DIR)/etc/samba/private/smbpasswd
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/samba.init $(TARGET_DIR)/etc/init.d/samba
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.03_samba $(TARGET_DIR)/etc/default/volatiles/03_samba
	$(UPDATE-RC.D) samba start 20 2 3 4 5 . stop 20 0 1 6 .
	$(PKG_REMOVE)
	$(TOUCH)
