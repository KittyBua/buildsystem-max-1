################################################################################
#
# coreutils
#
################################################################################

COREUTILS_VERSION = 9.1
COREUTILS_DIR     = coreutils-$(COREUTILS_VERSION)
COREUTILS_SOURCE  = coreutils-$(COREUTILS_VERSION).tar.xz
COREUTILS_SITE    = https://ftp.gnu.org/gnu/coreutils
COREUTILS_DEPENDS = bootstrap openssl

COREUTILS_CONF_ENV = \
	fu_cv_sys_stat_statfs2_bsize=yes

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
	$(call make-package)
