################################################################################
#
# xz
#
################################################################################

XZ_VERSION = 5.2.11
XZ_DIR = xz-$(XZ_VERSION)
XZ_SOURCE = xz-$(XZ_VERSION).tar.gz
XZ_SITE = https://tukaani.org/xz

XZ_CONF_OPTS = \
	--datarootdir=$(REMOVE_datarootdir) \
	--enable-small \
	--enable-assume-ram=4 \
	--disable-assembler \
	--disable-debug \
	--disable-doc \
	--disable-rpath \
	--disable-symbol-versions \
	--disable-werror \
	--with-pic

$(D)/xz: | bootstrap
	$(call autotools-package)
