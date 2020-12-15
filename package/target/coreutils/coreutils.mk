#
# coreutils
#
COREUTILS_VER    = 8.30
COREUTILS_DIR    = coreutils-$(COREUTILS_VER)
COREUTILS_SOURCE = coreutils-$(COREUTILS_VER).tar.xz
COREUTILS_SITE   = https://ftp.gnu.org/gnu/coreutils

COREUTILS_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--enable-largefile \
	--enable-silent-rules \
	--disable-xattr \
	--disable-libcap \
	--disable-acl \
	--without-gmp \
	--without-selinux

$(D)/coreutils: bootstrap openssl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		export fu_cv_sys_stat_statfs2_bsize=yes; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
