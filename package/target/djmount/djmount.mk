#
# djmount
#
DJMOUNT_VER    = 0.71
DJMOUNT_DIR    = djmount-$(DJMOUNT_VER)
DJMOUNT_SOURCE = djmount-$(DJMOUNT_VER).tar.gz
DJMOUNT_SITE   = https://sourceforge.net/projects/djmount/files/djmount/$(DJMOUNT_VER)

DJMOUNT_PATCH = \
	0001-fix-newer-gcc.patch \
	0002-fix-hang-with-asset-upnp.patch \
	0003-fix-incorrect-range-when-retrieving-content-via-HTTP.patch \
	0004-fix-new-autotools.patch \
	0005-fixed-crash-when-using-UTF-8-charset.patch \
	0006-fixed-crash.patch \
	0007-support-fstab-mounting.patch \
	0008-support-seeking-in-large-2gb-files.patch \
	0009-libupnp-1.6.6.patch \
	0010-libupnp-1.6.13.patch \
	0011-fix-build-with-gettext-0.20.x.patch

DJMOUNT_CONF_OPTS = \
	--with-external-libupnp \
	--with-fuse-prefix=$(TARGET_DIR)/usr \
	--with-libupnp-prefix=$(TARGET_DIR)/usr \
	--disable-debug

$(D)/djmount: bootstrap libupnp libfuse
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		touch libupnp/config.aux/config.rpath; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
