#
# nettle
#
NETTLE_VERSION = 3.5.1
NETTLE_DIR     = nettle-$(NETTLE_VERSION)
NETTLE_SOURCE  = nettle-$(NETTLE_VERSION).tar.gz
NETTLE_SITE    = https://ftp.gnu.org/gnu/nettle
NETTLE_DEPENDS = bootstrap gmp

NETTLE_CONF_OPTS = \
	--disable-documentation

$(D)/nettle:
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
	$(TOUCH)
