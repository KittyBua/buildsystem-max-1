#
# htop
#
HTOP_VER    = 3.0.5
HTOP_DIR    = htop-$(HTOP_VER)
HTOP_SOURCE = htop-$(HTOP_VER).tar.gz
HTOP_SITE   = $(call github,htop-dev,htop,$(HTOP_VER))
HTOP_DEPS   = bootstrap ncurses

HTOP_AUTORECONF = YES

HTOP_CONF_ENV = \
	ac_cv_file__proc_stat=yes \
	ac_cv_file__proc_meminfo=yes

HTOP_CONF_OPTS = \
	--disable-unicode \
	--disable-hwloc

$(D)/htop:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf htop $(TARGET_DIR)/usr/bin/top
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,applications icons pixmaps)
	$(TOUCH)
