#
# libfuse
#
LIBFUSE_VER    = 2.9.9
LIBFUSE_DIR    = fuse-$(LIBFUSE_VER)
LIBFUSE_SOURCE = fuse-$(LIBFUSE_VER).tar.gz
LIBFUSE_SITE   = https://github.com/libfuse/libfuse/releases/download/fuse-$(LIBFUSE_VER)

LIBFUSE_PATCH = \
	0001-fix-aarch64-build.patch

LIBFUSE_CONF_OPTS = \
	--disable-static \
	--disable-example \
	--disable-mtab \
	--with-gnu-ld \
	--enable-util \
	--enable-lib \
	--enable-silent-rules

$(D)/libfuse: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
