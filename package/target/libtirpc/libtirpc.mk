#
# libtirpc
#
LIBTIRPC_VER    = 1.2.6
LIBTIRPC_DIR    = libtirpc-$(LIBTIRPC_VER)
LIBTIRPC_SOURCE = libtirpc-$(LIBTIRPC_VER).tar.bz2
LIBTIRPC_SITE   = https://sourceforge.net/projects/libtirpc/files/libtirpc/$(LIBTIRPC_VER)
LIBTIRPC_DEPS   = bootstrap

LIBTIRPC_AUTORECONF = YES

LIBTIRPC_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -DGQ" \
	--disable-gssapi

$(D)/libtirpc:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
