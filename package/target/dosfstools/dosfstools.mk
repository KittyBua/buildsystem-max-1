#
# dosfstools
#
DOSFSTOOLS_VER    = 4.1
DOSFSTOOLS_DIR    = dosfstools-$(DOSFSTOOLS_VER)
DOSFSTOOLS_SOURCE = dosfstools-$(DOSFSTOOLS_VER).tar.xz
DOSFSTOOLS_SITE   = https://github.com/dosfstools/dosfstools/releases/download/v$(DOSFSTOOLS_VER)

DOSFSTOOLS_PATCH = \
	0001-switch-to-AC_CHECK_LIB-for-iconv-library-linking.patch

DOSFSTOOLS_CFLAGS = $(TARGET_CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -fomit-frame-pointer

DOSFSTOOLS_CONF_OPTS = \
	--sbindir=$(base_sbindir) \
	--docdir=$(REMOVE_docdir) \
	--without-udev \
	--enable-compat-symlinks \
	CFLAGS="$(DOSFSTOOLS_CFLAGS)"

$(D)/dosfstools: bootstrap libiconv
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
