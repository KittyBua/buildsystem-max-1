#
# popt
#
POPT_VERSION = 1.18
POPT_DIR     = popt-$(POPT_VERSION)
POPT_SOURCE  = popt-$(POPT_VERSION).tar.gz
POPT_SITE    = http://ftp.rpm.org/popt/releases/popt-1.x
POPT_DEPENDS = bootstrap

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
