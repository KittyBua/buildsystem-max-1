#
# makefile to build libstb-hal
#
# -----------------------------------------------------------------------------

LIBSTB_HAL_DEPS  = bootstrap
LIBSTB_HAL_DEPS += ffmpeg
LIBSTB_HAL_DEPS += openthreads

LH_CONFIG_OPTS =
#LH_CONFIG_OPTS += --enable-flv2mpeg4

LIBSTB_HAL_OBJ_DIR = $(BUILD_DIR)/$(LIBSTB_HAL_DIR)

# -----------------------------------------------------------------------------

#
# libstb-hal
#
LIBSTB_HAL_VER    = git
LIBSTB_HAL_DIR    = $(LIBSTB_HAL).git
LIBSTB_HAL_SOURCE = $(LIBSTB_HAL).git
LIBSTB_HAL_SITE   = $(GIT_SITE)

$(D)/libstb-hal.do_prepare: | $(LIBSTB_HAL_DEPS)
	$(START_BUILD)
	rm -rf $(SOURCE_DIR)/$(LIBSTB_HAL_DIR)
	rm -rf $(SOURCE_DIR)/$(LIBSTB_HAL_DIR).org
	rm -rf $(LIBSTB_HAL_OBJ_DIR)
	test -d $(SOURCE_DIR) || mkdir -p $(SOURCE_DIR)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(SOURCE_DIR))
	(cd $(SOURCE_DIR)/$(LIBSTB_HAL_DIR); git checkout -q $(LIBSTB_HAL_BRANCH);)
	cp -ra $(SOURCE_DIR)/$(LIBSTB_HAL_DIR) $(SOURCE_DIR)/$(LIBSTB_HAL_DIR).org
	$(CD) $(SOURCE_DIR)/$(LIBSTB_HAL_DIR); \
		$(call apply_patches,$(PKG_PATCH))
	@touch $@

$(D)/libstb-hal.config.status:
	rm -rf $(LIBSTB_HAL_OBJ_DIR)
	test -d $(LIBSTB_HAL_OBJ_DIR) || mkdir -p $(LIBSTB_HAL_OBJ_DIR)
	cd $(LIBSTB_HAL_OBJ_DIR); \
		$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/autogen.sh $(SILENT_OPT); \
		$(BUILD_ENV) \
		$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/configure $(SILENT_OPT) \
			--host=$(TARGET) \
			--build=$(BUILD) \
			--prefix=/usr \
			--enable-maintainer-mode \
			--enable-silent-rules \
			--enable-shared=no \
			\
			--with-target=cdk \
			--with-targetprefix=/usr \
			--with-boxtype=$(BOXTYPE) \
			--with-boxmodel=$(BOXMODEL) \
			$(LH_CONFIG_OPTS) \
			CFLAGS="$(N_CFLAGS)" CXXFLAGS="$(N_CFLAGS) -std=c++11" CPPFLAGS="$(N_CPPFLAGS)"
ifeq ($(TINKER_OPTION),0)
	@touch $@
endif

$(D)/libstb-hal.do_compile: libstb-hal.config.status
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) DESTDIR=$(TARGET_DIR)
	@touch $@

$(D)/libstb-hal: libstb-hal.do_prepare libstb-hal.do_compile
	$(MAKE) -C $(LIBSTB_HAL_OBJ_DIR) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
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
