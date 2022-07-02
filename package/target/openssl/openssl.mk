################################################################################
#
# openssl
#
################################################################################

OPENSSL_VERSION = 1.1.1o
OPENSSL_DIR     = openssl-$(OPENSSL_VERSION)
OPENSSL_SOURCE  = openssl-$(OPENSSL_VERSION).tar.gz
OPENSSL_SITE    = https://www.openssl.org/source
OPENSSL_DEPENDS = bootstrap

ifeq ($(TARGET_ARCH),arm)
OPENSSL_TARGET_ARCH = linux-armv4
else ifeq ($(TARGET_ARCH),aarch64)
OPENSSL_TARGET_ARCH = linux-aarch64
else ifeq ($(TARGET_ARCH),mips)
OPENSSL_TARGET_ARCH = linux-generic32
else ifeq ($(TARGET_ARCH),x86_64)
OPENSSL_TARGET_ARCH = linux-generic32
endif

OPENSSL_CONF_OPTS = \
	--cross-compile-prefix=$(TARGET_CROSS) \
	--prefix=/usr \
	--openssldir=/etc/ssl

OPENSSL_CONF_OPTS += \
	$(OPENSSL_TARGET_ARCH) \
	shared \
	threads \
	no-hw \
	no-rc5 \
	no-tests \
	no-fuzz-afl \
	no-fuzz-libfuzzer

OPENSSL_CONF_OPTS += \
	-DTERMIOS -fomit-frame-pointer \
	-DOPENSSL_SMALL_FOOTPRINT \
	$(TARGET_CFLAGS) \
	$(TARGET_LDFLAGS)

define OPENSSL_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_DIR)/etc/ssl/misc/,CA.pl tsget)
	rm -f $(addprefix $(TARGET_BIN_DIR)/,openssl c_rehash)
	rm -rf $(addprefix $(TARGET_LIB_DIR)/,engines-1.1)
endef
OPENSSL_TARGET_CLEANUP_HOOKS += OPENSSL_TARGET_CLEANUP

$(D)/openssl:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		./Configure $($(PKG)_CONF_OPTS); \
		$(MAKE) depend; \
		$(MAKE); \
		$(MAKE) install_sw install_ssldirs DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
