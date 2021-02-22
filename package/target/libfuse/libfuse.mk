#
# libfuse
#
LIBFUSE_VER    = 2.9.9
LIBFUSE_DIR    = fuse-$(LIBFUSE_VER)
LIBFUSE_SOURCE = fuse-$(LIBFUSE_VER).tar.gz
LIBFUSE_SITE   = https://github.com/libfuse/libfuse/releases/download/fuse-$(LIBFUSE_VER)
LIBFUSE_DEPS   = bootstrap

LIBFUSE_CONF_OPTS = \
	--disable-static \
	--disable-example \
	--disable-mtab \
	--with-gnu-ld \
	--enable-util \
	--enable-lib \
	--enable-silent-rules

$(D)/libfuse:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
