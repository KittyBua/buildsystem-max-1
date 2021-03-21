#
# coreutils
#
COREUTILS_VERSION = 8.30
COREUTILS_DIR     = coreutils-$(COREUTILS_VERSION)
COREUTILS_SOURCE  = coreutils-$(COREUTILS_VERSION).tar.xz
COREUTILS_SITE    = https://ftp.gnu.org/gnu/coreutils
COREUTILS_DEPENDS = bootstrap openssl

COREUTILS_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--enable-largefile \
	--enable-silent-rules \
	--disable-xattr \
	--disable-libcap \
	--disable-acl \
	--without-gmp \
	--without-selinux

$(D)/coreutils:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		export fu_cv_sys_stat_statfs2_bsize=yes; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
