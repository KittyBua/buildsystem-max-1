#
# openssl
#
OPENSSL_VER    = 1.1.1h
OPENSSL_DIR    = openssl-$(OPENSSL_VER)
OPENSSL_SOURCE = openssl-$(OPENSSL_VER).tar.gz
OPENSSL_SITE   = https://www.openssl.org/source

OPENSSL_PATCH = \
	0001-Dont-waste-time-building-manpages-if-we-re-not-going.patch \
	0002-Reproducible-build-do-not-leak-compiler-path.patch \
	0003-Introduce-the-OPENSSL_NO_MADVISE-to-disable-call-to-.patch \
	0004-Configure-use-ELFv2-ABI-on-some-ppc64-big-endian-sys.patch \
	0005-crypto-perlasm-ppc-xlate.pl-add-linux64v2-flavour.patch

ifeq ($(TARGET_ARCH),arm)
OPENSSL_TARGET_ARCH = linux-armv4
else ifeq ($(TARGET_ARCH),aarch64)
OPENSSL_TARGET_ARCH = linux-aarch64
else ifeq ($(TARGET_ARCH),mips)
OPENSSL_TARGET_ARCH = linux-generic32
endif

$(D)/openssl: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		./Configure $(SILENT_OPT) \
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
	$(PKG_REMOVE)
	$(TOUCH)
