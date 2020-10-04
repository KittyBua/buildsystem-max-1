#
# htop
#
HTOP_VER    = 3.0.2
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
			ac_cv_file__proc_stat=yes \
			ac_cv_file__proc_meminfo=yes \
			--prefix=/usr \
			--mandir=/.remove \
			--sysconfdir=/etc \
			--disable-unicode \
			--disable-hwloc \
			--enable-cgroup \
			--enable-taskstats \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,pixmaps applications)
	ln -sf htop $(TARGET_DIR)/usr/bin/top
	$(PKG_REMOVE)
	$(TOUCH)
