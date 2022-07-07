################################################################################
#
# libcap
#
################################################################################

LIBCAP_VERSION = 2.25
LIBCAP_DIR = libcap-$(LIBCAP_VERSION)
LIBCAP_SOURCE = libcap-$(LIBCAP_VERSION).tar.xz
LIBCAP_SITE = https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2

LIBCAP_DEPENDS = bootstrap

define LIBCAP_POST_PATCH
	$(SED) 's@^BUILD_GPERF@#\0@' $(PKG_BUILD_DIR)/Make.Rules
endef
LIBCAP_POST_PATCH_HOOKS = LIBCAP_POST_PATCH

LIBCAP_MAKE_FLAGS = \
	BUILD_CC="$(HOSTCC)" \
	BUILD_CFLAGS="$(HOST_CFLAGS)" \
	prefix=/usr \
	lib=lib

$(D)/libcap:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) -C libcap $(LIBCAP_MAKE_FLAGS); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) -C libcap $(LIBCAP_MAKE_FLAGS) DESTDIR=$(TARGET_DIR) install
	$(call TARGET_FOLLOWUP)
