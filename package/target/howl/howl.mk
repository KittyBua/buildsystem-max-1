#
# howl
#
HOWL_VER    = 1.0.0
HOWL_DIR    = howl-$(HOWL_VER)
HOWL_SOURCE = howl-$(HOWL_VER).tar.gz
HOWL_SITE   = https://sourceforge.net/projects/howl/files/howl/$(HOWL_VER)

HOWL_PATCH = \
	0001-ipv4-mapped-ipv6.patch

HOWL_CONF_OPTS = \
	--datadir=$(REMOVE_datarootdir)

$(D)/howl: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
