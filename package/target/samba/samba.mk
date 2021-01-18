#
# samba
#
SAMBA_VER    = 3.6.25
SAMBA_DIR    = samba-$(SAMBA_VER)
SAMBA_SOURCE = samba-$(SAMBA_VER).tar.gz
SAMBA_SITE   = https://ftp.samba.org/pub/samba/stable
SAMBA_DEPS   = bootstrap

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

$(D)/samba:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		cd source3; \
		./autogen.sh; \
		$(TARGET_CONFIGURE_ENV) \
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
		./configure $(TARGET_CONFIGURE_OPTS); \
		$(MAKE); \
		$(MAKE) installservers SBIN_PROGS="bin/samba_multicall" DESTDIR=$(TARGET_DIR) LOCALEDIR=$(REMOVE_localedir)
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
