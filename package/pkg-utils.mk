################################################################################
#
# makefile to keep buildsystem helpers
#
################################################################################

# Manipulation of .config files based on the Kconfig infrastructure.
# Used by the BusyBox package, the Linux kernel package, and more.

define KCONFIG_ENABLE_OPT # (option, file)
	$(SED) "/\\<$(1)\\>/d" $(2)
	echo '$(1)=y' >> $(2)
endef

define KCONFIG_SET_OPT # (option, value, file)
	$(SED) "/\\<$(1)\\>/d" $(3)
	echo '$(1)=$(2)' >> $(3)
endef

define KCONFIG_DISABLE_OPT # (option, file)
	$(SED) "/\\<$(1)\\>/d" $(2)
	echo '# $(1) is not set' >> $(2)
endef

# -----------------------------------------------------------------------------

# BS Revision
BS_REV=$(shell cd $(BASE_DIR); git log | grep "^commit" | wc -l)
# Neutrino mp Revision
NMP_REV=$(shell cd $(SOURCE_DIR)/$(NEUTRINO_DIR); git log | grep "^commit" | wc -l)
# libstb-hal Revision
HAL_REV=$(shell cd $(SOURCE_DIR)/$(LIBSTB_HAL_DIR); git log | grep "^commit" | wc -l)

# -----------------------------------------------------------------------------

rewrite-test:
	@printf "$(TERM_YELLOW)---> create rewrite-dependency_libs.txt ... "
	$(shell cd $(TARGET_DIR)/usr/lib && grep ^dependency_libs *.la > $(BUILD_DIR)/rewrite-dependency_libs.txt)
	@printf "done\n$(TERM_NORMAL)"
	@printf "$(TERM_YELLOW)---> create rewrite-libdir.txt ... "
	$(shell cd $(TARGET_DIR)/usr/lib && grep ^libdir *.la > $(BUILD_DIR)/rewrite-libdir.txt)
	@printf "done\n$(TERM_NORMAL)"
	@printf "$(TERM_YELLOW)---> create rewrite-pkgconfig.txt ... "
	$(shell cd $(TARGET_DIR)/usr/lib/pkgconfig && grep ^prefix * > $(BUILD_DIR)/rewrite-pkgconfig.txt)
	@printf "done\n$(TERM_NORMAL)"

patch:
	@make neutrino-patch
	@make libstb-hal-patch
	@make neutrino-plugins-patch

neutrino-patch:
	@printf "$(TERM_YELLOW)---> create $(NEUTRINO)-$(DATE).patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR)/$(NEUTRINO_DIR) && git diff > $(BUILD_DIR)/$(NEUTRINO)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

libstb-hal-patch:
	@printf "$(TERM_YELLOW)---> create $(LIBSTB_HAL)-$(DATE).patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR)/$(LIBSTB_HAL_DIR) && git diff > $(BUILD_DIR)/$(LIBSTB_HAL)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

neutrino-plugins-patch:
	@printf "$(TERM_YELLOW)---> create $(NEUTRINO_PLUGINS_DIR)-$(DATE).patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR)/$(NEUTRINO_PLUGINS_DIR) && git diff > $(BUILD_DIR)/$(NEUTRINO_PLUGINS_DIR)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

# -----------------------------------------------------------------------------

TUXBOX_CUSTOMIZE = [ -x support/scripts/$(notdir $@)-local.sh ] && \
	support/scripts/$(notdir $@)-local.sh \
	$(RELEASE_DIR) \
	$(TARGET_DIR) \
	$(BASE_DIR) \
	$(SOURCE_DIR) \
	$(IMAGE_DIR) \
	$(BOXMODEL) \
	$(FLAVOUR) \
	$(DATE) \
	|| true

# -----------------------------------------------------------------------------

ifeq ($(GITSSH),1)
MAX-GIT-GITHUB = git@github.com:MaxWiesel
URL_1          = https://github.com/MaxWiesel
URL_2          = $(MAX-GIT-GITHUB)
else
MAX-GIT-GITHUB = https://github.com/MaxWiesel
URL_1          = git@github.com:MaxWiesel
URL_2          = $(MAX-GIT-GITHUB)
endif

REPOSITORIES = \
	. \
	$(DL_DIR)/libstb-hal-max.git \
	$(DL_DIR)/neutrino-mp-max.git \
	$(DL_DIR)/neutrino-plugins.git \
	$(DL_DIR)/ofgwrite-nmp.git

switch-url:
	for repo in $(REPOSITORIES); do \
		$(SED) 's|url = $(URL_1)|url = $(URL_2)|' $$repo/.git/config; \
	done
