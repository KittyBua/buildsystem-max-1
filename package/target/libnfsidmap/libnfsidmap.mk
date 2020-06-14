#
# libnfsidmap
#
LIBNFSIDMAP_VER    = 0.25
LIBNFSIDMAP_DIR    = libnfsidmap-$(LIBNFSIDMAP_VER)
LIBNFSIDMAP_SOURCE = libnfsidmap-$(LIBNFSIDMAP_VER).tar.gz
LIBNFSIDMAP_URL    = http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap

$(D)/libnfsidmap: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
		ac_cv_func_malloc_0_nonnull=yes \
			--prefix=/usr \
			--mandir=/.remove \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
