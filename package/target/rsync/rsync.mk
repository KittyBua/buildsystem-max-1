################################################################################
#
# rsync
#
################################################################################

RSYNC_VERSION = 3.2.4
RSYNC_DIR = rsync-$(RSYNC_VERSION)
RSYNC_SOURCE = rsync-$(RSYNC_VERSION).tar.gz
RSYNC_SITE = https://download.samba.org/pub/rsync/src

RSYNC_DEPENDS = bootstrap

RSYNC_CONF_OPTS = \
	--with-included-zlib=no \
	--with-included-popt=no \
	--disable-simd \
	--disable-openssl \
	--disable-xxhash \
	--disable-zstd \
	--disable-lz4 \
	--disable-asm

$(D)/rsync:
	$(call autotools-package)
