#
# htop
#
HTOP_VERSION = 3.1.1
HTOP_DIR     = htop-$(HTOP_VERSION)
HTOP_SOURCE  = htop-$(HTOP_VERSION).tar.gz
HTOP_SITE    = $(call github,htop-dev,htop,$(HTOP_VERSION))
HTOP_DEPENDS = bootstrap ncurses libcap libnl

HTOP_AUTORECONF = YES

HTOP_CONF_ENV = \
	ac_cv_file__proc_stat=yes \
	ac_cv_file__proc_meminfo=yes

HTOP_CONF_OPTS = \
	--enable-affinity \
	--enable-capabilities \
	--enable-unicode \
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
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,applications icons pixmaps)
	$(TOUCH)
