################################################################################
#
# WAF package infrastructure
#
################################################################################

TARGET_WAF_OPTS = $(if $(VERBOSE),-v) -j $(PARALLEL_JOBS)

TARGET_WAF_CONFIGURE_OPTIONS = \
	--target=$(GNU_TARGET_NAME) \
	--prefix=$(prefix) \
	--exec-prefix=$(exec_prefix) \
	--bindir=$(bindir) \
	--datadir=$(datadir) \
	--includedir=$(includedir) \
	--libdir=$(libdir) \
	--mandir=$(REMOVE_mandir) \
	--datarootdir=$(datadir) \
	--sysconfdir=$(sysconfdir) \
	$($(PKG)_CONF_OPTS)

define TARGET_WAF_CONFIGURE_CMDS_DEFAULT
	$(CD) $(PKG_BUILD_DIR)/$($(PKG)_SUBDIR); \
	$(TARGET_CONFIGURE_ENV) \
	$($(PKG)_CONF_ENV) \
	$(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) \
		configure $(TARGET_WAF_CONFIGURE_OPTIONS) \
		$($(PKG)_CONF_OPTS) \
		$($(PKG)_WAF_OPTS)
endef

define TARGET_WAF_CONFIGURE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call TARGET_WAF_CONFIGURE_CMDS_DEFAULT)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define TARGET_WAF_BUILD_CMDS_DEFAULT
	$(CD) $(PKG_BUILD_DIR)/$($(PKG)_SUBDIR); \
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) \
		build $(TARGET_WAF_OPTS) $($(PKG)_BUILD_OPTS) \
		$($(PKG)_WAF_OPTS)
endef

define TARGET_WAF_BUILD
	@$(call MESSAGE,"Building")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_BUILD_CMDS)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define TARGET_WAF_INSTALL_CMDS_DEFAULT
	$(CD) $(PKG_BUILD_DIR)/$($(PKG)_SUBDIR); \
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) \
		install --destdir=$(TARGET_DIR) \
		$($(PKG)_INSTALL_TARGET_OPTS) \
		$($(PKG)_WAF_OPTS)
endef

define TARGET_WAF_INSTALL
	@$(call MESSAGE,"Installing")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_INSTALL_CMDS)
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

define waf-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(call TARGET_WAF_CONFIGURE)
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call TARGET_WAF_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call TARGET_WAF_INSTALL))
	$(call HOST_FOLLOWUP)
endef
