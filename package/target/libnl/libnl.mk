#
# libnl
#
LIBNL_VERSION = 3.5.0
LIBNL_DIR     = libnl-$(LIBNL_VERSION)
LIBNL_SOURCE  = libnl-$(LIBNL_VERSION).tar.gz
LIBNL_SITE    = https://github.com/thom311/libnl/releases/download/libnl3_5_0
LIBNL_DEPENDS = bootstrap

LIBNL_CONF_OPTS = \
	--disable-cli

$(D)/libnl:
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
