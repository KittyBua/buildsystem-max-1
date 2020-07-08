#
# libnfsidmap
#
LIBNFSIDMAP_VER    = 0.25
LIBNFSIDMAP_DIR    = libnfsidmap-$(LIBNFSIDMAP_VER)
LIBNFSIDMAP_SOURCE = libnfsidmap-$(LIBNFSIDMAP_VER).tar.gz
LIBNFSIDMAP_SITE   = http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap

$(D)/libnfsidmap: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
		ac_cv_func_malloc_0_nonnull=yes \
			--prefix=/usr \
			--mandir=/.remove \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
