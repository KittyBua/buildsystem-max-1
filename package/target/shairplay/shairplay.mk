#
# shairplay
#
SHAIRPLAY_VER      = git
SHAIRPLAY_DIR      = shairplay.git
SHAIRPLAY_SOURCE   = shairplay.git
SHAIRPLAY_SITE     = https://github.com/juhovh
SHAIRPLAY_CHECKOUT = 193138f3

SHAIRPLAY_PATCH  = \
	0001-shairplay-howl.patch

$(D)/shairplay: bootstrap libao howl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		git checkout -q $(SHAIRPLAY_CHECKOUT); \
		$(call apply_patches, $(PKG_PATCH)); \
		for A in src/test/example.c src/test/main.c src/shairplay.c ; do sed -i "s#airport.key#/usr/share/shairplay/airport.key#" $$A ; done && \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--enable-shared \
			--disable-static \
			--prefix=/usr \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		mkdir -p $(TARGET_SHARE_DIR)/shairplay; \
		$(INSTALL_DATA) airport.key $(TARGET_SHARE_DIR)/shairplay
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
