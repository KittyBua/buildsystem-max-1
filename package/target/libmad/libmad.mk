#
# libmad
#
LIBMAD_VERSION = 0.15.1b
LIBMAD_DIR     = libmad-$(LIBMAD_VERSION)
LIBMAD_SOURCE  = libmad_$(LIBMAD_VERSION).orig.tar.gz
LIBMAD_SITE    = http://snapshot.debian.org/archive/debian/20190310T213528Z/pool/main/libm/libmad
LIBMAD_DEPENDS = bootstrap

LIBMAD_AUTORECONF = YES

LIBMAD_PATCH = libmad_$(LIBMAD_VERSION)-10.diff.gz

define LIBMAD_APPLY_DEBIAN_PATCHES
	@if [ -d $(PKG_BUILD_DIR)/debian/patches ]; then \
		$(APPLY_PATCH) $(PKG_BUILD_DIR) $(PKG_BUILD_DIR)/debian/patches *.patch; \
	fi
endef
LIBMAD_POST_PATCH_HOOKS += LIBMAD_APPLY_DEBIAN_PATCHES

LIBMAD_CONF_OPTS = \
	--enable-shared=yes \
	--enable-accuracy \
	--enable-sso \
	--disable-debugging \
	$(if $(filter $(TARGET_ARCH),arm mips),--enable-fpm=$(TARGET_ARCH),--enable-fpm=64bit)

libmad:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
