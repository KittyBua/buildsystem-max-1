#
# libmad
#
LIBMAD_VER    = 0.15.1b
LIBMAD_DIR    = libmad-$(LIBMAD_VER)
LIBMAD_SOURCE = libmad_$(LIBMAD_VER).orig.tar.gz
LIBMAD_SITE   = http://snapshot.debian.org/archive/debian/20190310T213528Z/pool/main/libm/libmad
LIBMAD_DEPS   = bootstrap

LIBMAD_AUTORECONF = YES

LIBMAD_PATCH = libmad_$(LIBMAD_VER)-10.diff.gz

define LIBMAD_APPLY_DEBIAN_PATCHES
	if [ -d $(PKG_BUILD_DIR)/debian/patches ]; then \
		$(APPLY_PATCHES) $(PKG_BUILD_DIR) $(PKG_BUILD_DIR)/debian/patches *.patch; \
	fi
endef
LIBMAD_POST_PATCH_HOOKS += LIBMAD_APPLY_DEBIAN_PATCHES

LIBMAD_CONF_OPTS = \
	--enable-shared=yes \
	--enable-accuracy \
	--enable-sso \
	--disable-debugging \
	$(if $(filter $(TARGET_ARCH),arm mips),--enable-fpm=$(TARGET_ARCH),--enable-fpm=64bit)

$(D)/libmad:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
