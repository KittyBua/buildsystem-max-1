#
# popt
#
POPT_VER    = 1.16
POPT_DIR    = popt-$(POPT_VER)
POPT_SOURCE = popt-$(POPT_VER).tar.gz
POPT_SITE   = ftp://anduin.linuxfromscratch.org/BLFS/popt
POPT_DEPS   = bootstrap

POPT_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--disable-static

$(D)/popt:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
