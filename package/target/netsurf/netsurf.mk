################################################################################
#
# netsurf
#
################################################################################

NETSURF_VERSION = 3.10
NETSURF_DIR     = netsurf-all-$(NETSURF_VERSION)
NETSURF_SOURCE  = netsurf-all-$(NETSURF_VERSION).tar.gz
NETSURF_SITE    = http://download.netsurf-browser.org/netsurf/releases/source-full
NETSURF_DEPENDS = bootstrap $(SHARE_NEUTRINO_PLUGINS) libpng libjpeg-turbo openssl libiconv freetype expat libcurl

NETSURF_CONF_OPTS = \
	PREFIX=/usr \
	TMP_PREFIX=$(BUILD_DIR)/netsurf-all-$(NETSURF_VERSION)/tmpusr \
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
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		CFLAGS="$(TARGET_CFLAGS) -I$(BUILD_DIR)/netsurf-all-$(NETSURF_VERSION)/tmpusr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L$(BUILD_DIR)/netsurf-all-$(NETSURF_VERSION)/tmpusr/lib" \
		$(MAKE) $($(PKG)_CONF_OPTS) build; \
		$(MAKE) $($(PKG)_CONF_OPTS) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_BIN_DIR)/netsurf-fb $(SHARE_NEUTRINO_PLUGINS)/netsurf-fb.so
	echo "name=Netsurf Web Browser"	 > $(SHARE_NEUTRINO_PLUGINS)/netsurf-fb.cfg
	echo "desc=Web Browser"		>> $(SHARE_NEUTRINO_PLUGINS)/netsurf-fb.cfg
	echo "type=2"			>> $(SHARE_NEUTRINO_PLUGINS)/netsurf-fb.cfg
	$(call TARGET_FOLLOWUP)
