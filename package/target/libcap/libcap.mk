#
# libcap
#
LIBCAP_VER    = 2.25
LIBCAP_DIR    = libcap-$(LIBCAP_VER)
LIBCAP_SOURCE = libcap-$(LIBCAP_VER).tar.xz
LIBCAP_SITE   = https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2

LIBCAP_PATCH = \
	0001-build-system-fixes-for-cross-compilation.patch \
	0002-libcap-split-install-into-install-shared-install-sta.patch \
	0003-libcap-cap_file.c-fix-build-with-old-kernel-headers.patch

LIBCAP_MAKE_FLAGS = \
	BUILD_CC="$(HOSTCC)" \
	BUILD_CFLAGS="$(HOST_CFLAGS)"

$(D)/libcap: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		sed 's@^BUILD_GPERF@#\0@' -i Make.Rules; \
		$(BUILD_ENV) $(MAKE) -C libcap $(LIBCAP_MAKE_FLAGS) prefix=/usr lib=lib; \
		$(BUILD_ENV) $(MAKE) -C libcap $(LIBCAP_MAKE_FLAGS) prefix=/usr lib=lib DESTDIR=$(TARGET_DIR) install
	$(PKG_REMOVE)
	$(TOUCH)
