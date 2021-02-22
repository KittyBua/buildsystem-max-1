#
# libnfsidmap
#
LIBNFSIDMAP_VER    = 0.25
LIBNFSIDMAP_DIR    = libnfsidmap-$(LIBNFSIDMAP_VER)
LIBNFSIDMAP_SOURCE = libnfsidmap-$(LIBNFSIDMAP_VER).tar.gz
LIBNFSIDMAP_SITE   = http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap
LIBNFSIDMAP_DEPS   = bootstrap

LIBNFSIDMAP_CONF_OPTS = \
	ac_cv_func_malloc_0_nonnull=yes

$(D)/libnfsidmap:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
