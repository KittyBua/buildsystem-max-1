#
# openssl
#
OPENSSL_VER    = 1.1.1h
OPENSSL_DIR    = openssl-$(OPENSSL_VER)
OPENSSL_SOURCE = openssl-$(OPENSSL_VER).tar.gz
OPENSSL_SITE   = https://www.openssl.org/source
OPENSSL_DEPS   = bootstrap

ifeq ($(TARGET_ARCH),arm)
OPENSSL_TARGET_ARCH = linux-armv4
else ifeq ($(TARGET_ARCH),aarch64)
OPENSSL_TARGET_ARCH = linux-aarch64
else ifeq ($(TARGET_ARCH),mips)
OPENSSL_TARGET_ARCH = linux-generic32
endif

$(D)/openssl:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./Configure \
			$(OPENSSL_TARGET_ARCH) \
			--prefix=/usr \
			--openssldir=/etc/ssl \
			shared \
			no-hw \
			no-rc5 \
			no-tests \
			no-fuzz-libfuzzer \
			no-fuzz-afl \
			\
			$(TARGET_CFLAGS) \
			-DTERMIOS -fomit-frame-pointer \
			-DOPENSSL_SMALL_FOOTPRINT \
			$(TARGET_LDFLAGS) \
			--cross-compile-prefix=$(TARGET_CROSS) \
			; \
		$(MAKE) depend; \
		$(MAKE); \
		$(MAKE) install_sw install_ssldirs DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/etc/ssl/misc/,CA.pl tsget)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,openssl c_rehash)
	rm -rf $(addprefix $(TARGET_DIR)/usr/lib/,engines-1.1)
	$(REMOVE)
	$(TOUCH)
