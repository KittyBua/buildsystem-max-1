#
# htop
#
HTOP_VER    = 3.0.1
HTOP_DIR    = htop-$(HTOP_VER)
HTOP_SOURCE = htop-$(HTOP_VER).tar.gz
HTOP_SITE   = $(call github,htop-dev,htop,$(HTOP_VER))

HTOP_PATCH  = \
	0001-Use-pkg-config.patch

$(D)/htop: bootstrap ncurses
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--sysconfdir=/etc \
			--disable-unicode \
			--enable-cgroup \
			--enable-proc \
			--enable-taskstats \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,pixmaps applications)
	ln -sf htop $(TARGET_DIR)/usr/bin/top
	$(PKG_REMOVE)
	$(TOUCH)
