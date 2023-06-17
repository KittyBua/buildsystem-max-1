################################################################################
#
# Autotools package infrastructure
#
################################################################################

define AUTORECONF_HOOK
	if [ "$($(PKG)_AUTORECONF)" == "YES" ]; then \
		$(call MESSAGE,"Autoreconfiguring"); \
		$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
			$($(PKG)_AUTORECONF_ENV) \
			$($(PKG)_AUTORECONF_CMD) \
				$($(PKG)_AUTORECONF_OPTS); \
	fi
endef

# -----------------------------------------------------------------------------

define TARGET_CONFIGURE_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR) && rm -rf config.cache && \
	test -f ./$($(PKG)_CONFIGURE_CMD) || ./autogen.sh && \
	$(TARGET_CONFIGURE_ARGS) \
	$(TARGET_CONFIGURE_ENV) \
	$($(PKG)_CONF_ENV) \
	CONFIG_SITE=/dev/null \
	./$($(PKG)_CONFIGURE_CMD) \
		--build=$(GNU_HOST_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--target=$(GNU_TARGET_NAME) \
		\
		--program-prefix="" \
		--program-suffix="" \
		\
		--prefix=$(prefix) \
		--exec-prefix=$(exec_prefix) \
		--bindir=$(bindir) \
		--datadir=$(datadir) \
		--includedir=$(includedir) \
		--libdir=$(libdir) \
		--libexecdir=$(libexecdir) \
		--oldincludedir=$(oldincludedir) \
		--sbindir=$(sbindir) \
		--sharedstatedir=$(sharedstatedir) \
		--sysconfdir=$(sysconfdir) \
		--localstatedir=$(localstatedir) \
		\
		--mandir=$(REMOVE_mandir) \
		--infodir=$(REMOVE_infodir) \
		\
		$($(PKG)_CONF_OPTS)
endef

define TARGET_CONFIGURE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_CONFIGURE_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call AUTORECONF_HOOK)
	$(Q)$(call $(PKG)_CONFIGURE_CMDS)
	$(foreach hook,$($(PKG)_POST_CONFIGURE_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

define autotools-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_CONFIGURE)),,$(call TARGET_CONFIGURE))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call TARGET_MAKE_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call TARGET_MAKE_INSTALL))
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Host autotools package infrastructure
#
################################################################################

define HOST_CONFIGURE_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR) && rm -rf config.cache && \
	test -f ./$($(PKG)_CONFIGURE_CMD) || ./autogen.sh && \
	$(HOST_CONFIGURE_ENV) \
	$($(PKG)_CONF_ENV) \
	CONFIG_SITE=/dev/null \
	./$($(PKG)_CONFIGURE_CMD) \
		--prefix=$(HOST_DIR) \
		--sysconfdir=$(HOST_DIR)/etc \
		\
		$($(PKG)_CONF_OPTS)
endef

define HOST_CONFIGURE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_CONFIGURE_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call AUTORECONF_HOOK)
	$(Q)$(call $(PKG)_CONFIGURE_CMDS)
	$(foreach hook,$($(PKG)_POST_CONFIGURE_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

define host-autotools-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_CONFIGURE)),,$(call HOST_CONFIGURE))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call HOST_MAKE_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call HOST_MAKE_INSTALL))
	$(call HOST_FOLLOWUP)
endef
