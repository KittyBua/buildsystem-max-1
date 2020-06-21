#
# fribidi
#
FRIBIDI_VER    = 1.0.9
FRIBIDI_DIR    = fribidi-$(FRIBIDI_VER)
FRIBIDI_SOURCE = fribidi-$(FRIBIDI_VER).tar.xz
FRIBIDI_SITE   = https://github.com/fribidi/fribidi/releases/download/v$(FRIBIDI_VER)

FRIBIDI_PATCH  = \
	0001-fribidi.patch

$(D)/fribidi: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-shared \
			--enable-static \
			--disable-debug \
			--disable-deprecated \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	cd $(TARGET_DIR) && rm usr/bin/fribidi
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
