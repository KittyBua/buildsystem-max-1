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

LIBSTB_HAL_CONF_OPTS = \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--prefix=$(prefix) \
	--enable-maintainer-mode \
	--enable-silent-rules \
	--enable-shared=no \
	\
	--with-target=cdk \
	--with-targetprefix=$(prefix) \
	--with-boxtype=$(BOXTYPE) \
	--with-boxmodel=$(BOXMODEL) \
	\
	CFLAGS="$(NEUTRINO_CFLAGS)" \
	CXXFLAGS="$(NEUTRINO_CFLAGS) -std=c++11" \
	CPPFLAGS="$(NEUTRINO_CPPFLAGS)"

LIBSTB_HAL_CONF_OPTS += \
	--enable-flv2mpeg4

LIBSTB_HAL_OBJ_DIR = $(BUILD_DIR)/$(LIBSTB_HAL_DIR)

$(D)/libstb-hal.do_prepare:
	$(START_BUILD)
	rm -rf $(SOURCE_DIR)/$(LIBSTB_HAL_DIR)
	rm -rf $(SOURCE_DIR)/$(LIBSTB_HAL_DIR).org
	rm -rf $(LIBSTB_HAL_OBJ_DIR)
	test -d $(SOURCE_DIR) || mkdir -p $(SOURCE_DIR)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(SOURCE_DIR))
	$(call APPLY_PATCHES_S,$(LIBSTB_HAL_DIR))
	@touch $@

$(D)/libstb-hal.config.status:
	rm -rf $(LIBSTB_HAL_OBJ_DIR)
	test -d $(LIBSTB_HAL_OBJ_DIR) || mkdir -p $(LIBSTB_HAL_OBJ_DIR)
	$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/autogen.sh
	$(CD) $(LIBSTB_HAL_OBJ_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/configure \
			$(LIBSTB_HAL_CONF_OPTS)
ifeq ($(TINKER_OPTION),0)
	@touch $@
endif

$(D)/libstb-hal.do_compile: libstb-hal.config.status
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) DESTDIR=$(TARGET_DIR)
	@touch $@

$(D)/libstb-hal: $(LIBSTB_HAL_DEPENDS) libstb-hal.do_prepare libstb-hal.do_compile
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(TOUCH)

# -----------------------------------------------------------------------------

libstb-hal-clean:
	rm -f $(D)/libstb-hal
	rm -f $(D)/libstb-hal.config.status
	rm -f $(D)/neutrino.config.status
	cd $(LIBSTB_HAL_OBJ_DIR); \
		$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) distclean

libstb-hal-distclean:
	rm -rf $(LIBSTB_HAL_OBJ_DIR)
	rm -f $(D)/libstb-hal*
	rm -f $(D)/neutrino.config.status

libstb-hal-uninstall:
	-make -C $(LIBSTB_HAL_OBJ_DIR) uninstall DESTDIR=$(TARGET_DIR)
