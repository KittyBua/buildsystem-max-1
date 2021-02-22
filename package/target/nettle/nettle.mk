#
# nettle
#
NETTLE_VER    = 3.5.1
NETTLE_DIR    = nettle-$(NETTLE_VER)
NETTLE_SOURCE = nettle-$(NETTLE_VER).tar.gz
NETTLE_SITE   = https://ftp.gnu.org/gnu/nettle
NETTLE_DEPS   = bootstrap gmp

NETTLE_CONF_OPTS = \
	--disable-documentation

$(D)/nettle:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
