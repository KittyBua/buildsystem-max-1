################################################################################
#
# WAF package infrastructure
#
################################################################################

WAF_OPTS = $(if $(VERBOSE),-v) -j $(PARALLEL_JOBS)

WAF_CONFIGURE_OPTIONS = \
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

define WAF_CONFIGURE_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
	$(TARGET_CONFIGURE_ENV) \
	$($(PKG)_CONF_ENV) \
	$(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) \
		configure $(WAF_CONFIGURE_OPTIONS) \
		$($(PKG)_CONF_OPTS) \
		$($(PKG)_WAF_OPTS)
endef

define WAF_CONFIGURE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call WAF_CONFIGURE_CMDS_DEFAULT)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define WAF_BUILD_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) \
		build $(WAF_OPTS) $($(PKG)_BUILD_OPTS) \
		$($(PKG)_WAF_OPTS)
endef

define WAF_BUILD
	@$(call MESSAGE,"Building")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call WAF_BUILD_CMDS_DEFAULT)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define WAF_INSTALL_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
	$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) $(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) \
		install --destdir=$(TARGET_DIR) \
		$($(PKG)_INSTALL_TARGET_OPTS) \
		$($(PKG)_WAF_OPTS)
endef

define WAF_INSTALL
	@$(call MESSAGE,"Installing")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call WAF_INSTALL_CMDS_DEFAULT)
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

define waf-package
	$(call PREPARE,$(1))
	$(call WAF_CONFIGURE)
	$(call WAF_BUILD)
	$(call WAF_INSTALL)
	$(call HOST_FOLLOWUP)
endef
