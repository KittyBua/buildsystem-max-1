#
# htop
#
HTOP_VER    = 3.0.3
HTOP_DIR    = htop-$(HTOP_VER)
HTOP_SOURCE = htop-$(HTOP_VER).tar.gz
HTOP_SITE   = $(call github,htop-dev,htop,$(HTOP_VER))

HTOP_CONF_OPTS = \
	ac_cv_file__proc_stat=yes \
	ac_cv_file__proc_meminfo=yes \
	--disable-unicode \
	--disable-hwloc \
	--enable-cgroup \
	--enable-taskstats

$(D)/htop: bootstrap ncurses
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,applications icons pixmaps)
	ln -sf htop $(TARGET_DIR)/usr/bin/top
	$(PKG_REMOVE)
	$(TOUCH)
