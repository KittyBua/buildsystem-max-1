#
# libtirpc
#
LIBTIRPC_VER    = 1.2.6
LIBTIRPC_DIR    = libtirpc-$(LIBTIRPC_VER)
LIBTIRPC_SOURCE = libtirpc-$(LIBTIRPC_VER).tar.bz2
LIBTIRPC_SITE   = https://sourceforge.net/projects/libtirpc/files/libtirpc/$(LIBTIRPC_VER)

LIBTIRPC_PATCH = \
	0001-Disable-parts-of-TIRPC-requiring-NIS-support.patch \
	0003-Automatically-generate-XDR-header-files-from-.x-sour.patch \
	0004-Add-more-XDR-files-needed-to-build-rpcbind-on-top-of.patch

LIBTIRPC_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -DGQ" \
	--disable-gssapi

$(D)/libtirpc: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
