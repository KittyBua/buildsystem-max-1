################################################################################
#
# parted
#
################################################################################

PARTED_VERSION = 3.2
PARTED_DIR     = parted-$(PARTED_VERSION)
PARTED_SOURCE  = parted-$(PARTED_VERSION).tar.xz
PARTED_SITE    = https://ftp.gnu.org/gnu/parted
PARTED_DEPENDS = bootstrap e2fsprogs libiconv

PARTED_AUTORECONF = YES

PARTED_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--disable-pc98 \
	--disable-nls \
	--disable-device-mapper \
	--without-readline

$(D)/parted:
	$(call make-package)
