#
# netsurf
#
NETSURF_VER    = 3.8
NETSURF_DIR    = netsurf-all-$(NETSURF_VER)
NETSURF_SOURCE = netsurf-all-$(NETSURF_VER).tar.gz
NETSURF_SITE   = http://download.netsurf-browser.org/netsurf/releases/source-full

NETSURF_PATCH  = \
	0001-netsurf-32bpp-xbgr8888.patch \
	0002-netsurf-event.patch \
	0003-netsurf-framebuffer.patch \
	0004-netsurf-gui.patch \
	0005-netsurf-linux.patch \
	0006-netsurf-osk.patch \
	0007-netsurf-text.patch

NETSURF_ENV = \
	PREFIX=/usr \
	TMP_PREFIX=$(BUILD_DIR)/netsurf-all-$(NETSURF_VER)/tmpusr \
	NETSURF_USE_DUKTAPE=NO \
	NETSURF_USE_LIBICONV_PLUG=NO \
	NETSURF_FB_FONTLIB=freetype \
	NETSURF_FB_FRONTEND=linux \
	NETSURF_FB_RESPATH=/usr/share/netsurf/ \
	NETSURF_FRAMEBUFFER_RESOURCES=/usr/share/netsurf/ \
	NETSURF_FB_FONTPATH=/usr/share/fonts \
	NETSURF_FB_FONT_SANS_SERIF=neutrino.ttf \
	TARGET=framebuffer

$(D)/netsurf: bootstrap libpng libjpeg-turbo openssl libiconv freetype expat libcurl
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		CFLAGS="$(TARGET_CFLAGS) -I$(BUILD_DIR)/netsurf-all-$(NETSURF_VER)/tmpusr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L$(BUILD_DIR)/netsurf-all-$(NETSURF_VER)/tmpusr/lib" \
		PKG_CONFIG="$(PKG_CONFIG)" \
		$(MAKE) $(NETSURF_ENV); \
		$(MAKE) $(NETSURF_ENV) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins
	mv $(TARGET_DIR)/usr/bin/netsurf-fb $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.so
	echo "name=Netsurf Web Browser"	 > $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.cfg
	echo "desc=Web Browser"		>> $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.cfg
	echo "type=2"			>> $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.cfg
	$(PKG_REMOVE)
	$(TOUCH)
