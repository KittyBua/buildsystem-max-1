#
# dosfstools
#
DOSFSTOOLS_VER    = 4.1
DOSFSTOOLS_DIR    = dosfstools-$(DOSFSTOOLS_VER)
DOSFSTOOLS_SOURCE = dosfstools-$(DOSFSTOOLS_VER).tar.xz
DOSFSTOOLS_SITE   = https://github.com/dosfstools/dosfstools/releases/download/v$(DOSFSTOOLS_VER)
DOSFSTOOLS_DEPS   = bootstrap libiconv

DOSFSTOOLS_AUTORECONF = YES

DOSFSTOOLS_CFLAGS = $(TARGET_CFLAGS) -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -fomit-frame-pointer

DOSFSTOOLS_CONF_OPTS = \
	--sbindir=$(base_sbindir) \
	--docdir=$(REMOVE_docdir) \
	--without-udev \
	--enable-compat-symlinks \
	CFLAGS="$(DOSFSTOOLS_CFLAGS)"

$(D)/dosfstools:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
