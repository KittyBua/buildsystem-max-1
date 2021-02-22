#
# netsurf
#
NETSURF_VER    = 3.10
NETSURF_DIR    = netsurf-all-$(NETSURF_VER)
NETSURF_SOURCE = netsurf-all-$(NETSURF_VER).tar.gz
NETSURF_SITE   = http://download.netsurf-browser.org/netsurf/releases/source-full
NETSURF_DEPS   = bootstrap libpng libjpeg-turbo openssl libiconv freetype expat libcurl

NETSURF_CONF_OPTS = \
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

$(D)/netsurf:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		CFLAGS="$(TARGET_CFLAGS) -I$(BUILD_DIR)/netsurf-all-$(NETSURF_VER)/tmpusr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L$(BUILD_DIR)/netsurf-all-$(NETSURF_VER)/tmpusr/lib" \
		$(MAKE) $($(PKG)_CONF_OPTS); \
		$(MAKE) $($(PKG)_CONF_OPTS) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins
	mv $(TARGET_DIR)/usr/bin/netsurf-fb $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.so
	echo "name=Netsurf Web Browser"	 > $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.cfg
	echo "desc=Web Browser"		>> $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.cfg
	echo "type=2"			>> $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins/netsurf-fb.cfg
	$(REMOVE)
	$(TOUCH)
