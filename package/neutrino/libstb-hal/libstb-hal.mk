#
# makefile to build libstb-hal
#
# -----------------------------------------------------------------------------

#
# libstb-hal
#
LIBSTB_HAL_VERSION = git
LIBSTB_HAL_DIR     = $(LIBSTB_HAL).git
LIBSTB_HAL_SOURCE  = $(LIBSTB_HAL).git
LIBSTB_HAL_SITE    = $(GIT_SITE)
LIBSTB_HAL_DEPENDS = bootstrap ffmpeg openthreads

LIBSTB_HAL_CONF_ENV = \
	$(NEUTRINO_CONF_ENV)

ifneq ($(BOXMODEL),generic)
LIBSTB_HAL_CONF_OPTS = \
	--prefix=$(prefix) \
	--with-target=cdk \
	--with-targetprefix=$(prefix)
else
LIBSTB_HAL_CONF_OPTS = \
	--prefix=$(TARGET_DIR)/usr \
	--with-target=native \
	--with-targetprefix=$(TARGET_DIR)/usr

ifeq ($(MEDIAFW),gstreamer)
LIBSTB_HAL_CONF_OPTS += \
	--enable-gstreamer

LIBSTB_HAL_CONF_ENV += \
	PKG_CONFIG_PATH=$(PKG_CONFIG_PATH):/usr/lib/$(GNU_TARGET_NAME)/pkgconfig/

GST_CFLAGS = \
	-I/usr/include \
	-I/usr/include/glib-2.0 \
	-I/usr/include/gstreamer-1.0 \
	-I/usr/lib/$(GNU_TARGET_NAME)/glib-2.0/include \
	$(shell pkg-config --cflags --libs gstreamer-1.0) \
	$(shell pkg-config --cflags --libs gstreamer-audio-1.0) \
	$(shell pkg-config --cflags --libs gstreamer-video-1.0)
endif
endif

LIBSTB_HAL_CONF_OPTS += \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--enable-maintainer-mode \
	--enable-silent-rules \
	--enable-shared=no \
	\
	--with-boxtype=$(BOXTYPE) \
	--with-boxmodel=$(BOXMODEL) \
	\
	CFLAGS="$(NEUTRINO_CFLAGS) $(GST_CFLAGS)" \
	CXXFLAGS="$(NEUTRINO_CFLAGS) $(GST_CFLAGS) -std=c++11" \
	CPPFLAGS="$(NEUTRINO_CPPFLAGS) $(GST_CFLAGS)"

LIBSTB_HAL_CONF_OPTS += \
	--enable-flv2mpeg4

LIBSTB_HAL_OBJ_DIR = $(BUILD_DIR)/$(LIBSTB_HAL_DIR)

$(D)/libstb-hal.do_prepare:
	$(START_BUILD)
	rm -rf $(SOURCE_DIR)/$(LIBSTB_HAL_DIR)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(SOURCE_DIR))
	$(call APPLY_PATCHES_S,$(LIBSTB_HAL_DIR))
	@touch $@

$(D)/libstb-hal.config.status:
	rm -rf $(LIBSTB_HAL_OBJ_DIR)
	mkdir -p $(LIBSTB_HAL_OBJ_DIR)
	$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/autogen.sh
	$(CD) $(LIBSTB_HAL_OBJ_DIR); \
		$(LIBSTB_HAL_CONF_ENV) \
		$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/configure \
			$(LIBSTB_HAL_CONF_OPTS)
ifeq ($(TINKER_OPTION),0)
	@touch $@
endif

$(D)/libstb-hal.do_compile: libstb-hal.config.status
ifneq ($(BOXMODEL),generic)
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) DESTDIR=$(TARGET_DIR)
else
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR)
endif
	@touch $@

$(D)/libstb-hal: $(LIBSTB_HAL_DEPENDS) libstb-hal.do_prepare libstb-hal.do_compile
ifneq ($(BOXMODEL),generic)
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) install DESTDIR=$(TARGET_DIR)
else
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) install
endif
	$(REWRITE_LIBTOOL)
	$(TOUCH)

# -----------------------------------------------------------------------------

libstb-hal-clean:
	rm -f $(D)/libstb-hal
	rm -f $(D)/libstb-hal.config.status
	rm -f $(D)/libstb-hal.do_compile

libstb-hal-distclean:
	rm -f $(D)/libstb-hal
	rm -f $(D)/libstb-hal.config.status
	rm -f $(D)/libstb-hal.do_compile
	rm -f $(D)/libstb-hal.do_prepare

libstb-hal-uninstall:
	-make -C $(LIBSTB_HAL_OBJ_DIR) uninstall DESTDIR=$(TARGET_DIR)
