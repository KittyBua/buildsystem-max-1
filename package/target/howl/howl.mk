#
# howl
#
HOWL_VER    = 1.0.0
HOWL_DIR    = howl-$(HOWL_VER)
HOWL_SOURCE = howl-$(HOWL_VER).tar.gz
HOWL_SITE   = https://sourceforge.net/projects/howl/files/howl/$(HOWL_VER)

HOWL_PATCH  = \
	0001-ipv4-mapped-ipv6.patch

$(D)/howl: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--mandir=/.remove \
			--datadir=/.remove \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
