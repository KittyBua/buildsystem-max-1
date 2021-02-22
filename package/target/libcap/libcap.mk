#
# libcap
#
LIBCAP_VER    = 2.25
LIBCAP_DIR    = libcap-$(LIBCAP_VER)
LIBCAP_SOURCE = libcap-$(LIBCAP_VER).tar.xz
LIBCAP_SITE   = https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2
LIBCAP_DEPS   = bootstrap

define LIBCAP_POST_PATCH
	$(SED) 's@^BUILD_GPERF@#\0@' $(PKG_BUILD_DIR)/Make.Rules
endef
LIBCAP_POST_PATCH_HOOKS = LIBCAP_POST_PATCH

LIBCAP_MAKE_FLAGS = \
	BUILD_CC="$(HOSTCC)" \
	BUILD_CFLAGS="$(HOST_CFLAGS)"

$(D)/libcap:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) -C libcap $(LIBCAP_MAKE_FLAGS) prefix=/usr lib=lib; \
		$(TARGET_CONFIGURE_ENV) $(MAKE) -C libcap $(LIBCAP_MAKE_FLAGS) prefix=/usr lib=lib DESTDIR=$(TARGET_DIR) install
	$(REMOVE)
	$(TOUCH)
