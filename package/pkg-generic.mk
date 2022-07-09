################################################################################
#
# Generic package infrastructure
#
################################################################################

TARGET_MAKE_ENV = \
	PATH=$(PATH)

define TARGET_MAKE_BUILD_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$($(PKG)_MAKE) $($(PKG)_MAKE_ARGS)\
			$($(PKG)_MAKE_OPTS)
endef

define TARGET_MAKE_BUILD
	@$(call MESSAGE,"Building")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_BUILD_CMDS,$(1))
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define TARGET_MAKE_INSTALL_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(TARGET_MAKE_ENV) $($(PKG)_MAKE_INSTALL_ENV) \
		$($(PKG)_MAKE_INSTALL) $($(PKG)_MAKE_INSTALL_ARGS) DESTDIR=$(TARGET_DIR) \
			$($(PKG)_MAKE_INSTALL_OPTS)
endef

define TARGET_MAKE_INSTALL
	@$(call MESSAGE,"Installing to target")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_INSTALL_CMDS,$(1))
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(if $(BS_INIT_SYSTEMD),\
		$($(PKG)_INSTALL_INIT_SYSTEMD))
	$(if $(BS_INIT_SYSV),\
		$($(PKG)_INSTALL_INIT_SYSV))
endef

# -----------------------------------------------------------------------------

define generic-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call TARGET_MAKE_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call TARGET_MAKE_INSTALL))
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Host make package infrastructure
#
################################################################################

HOST_MAKE_ENV = \
	PATH=$(PATH) \
	PKG_CONFIG=/usr/bin/pkg-config \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_LIBDIR="$(HOST_DIR)/lib/pkgconfig:$(HOST_DIR)/share/pkgconfig"

define HOST_MAKE_BUILD_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(HOST_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$($(PKG)_MAKE) $($(PKG)_MAKE_ARGS)\
			$($(PKG)_MAKE_OPTS)
endef

define HOST_MAKE_BUILD
	@$(call MESSAGE,"Compiling")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_BUILD_CMDS,$(1))
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define HOST_MAKE_INSTALL_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(HOST_MAKE_ENV) $($(PKG)_MAKE_INSTALL_ENV) \
		$($(PKG)_MAKE_INSTALL) $($(PKG)_MAKE_INSTALL_ARGS) \
			$($(PKG)_MAKE_INSTALL_OPTS)
endef

define HOST_MAKE_INSTALL
	@$(call MESSAGE,"Installing to host")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_INSTALL_CMDS,$(1))
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

define host-generic-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call HOST_MAKE_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call HOST_MAKE_INSTALL))
	$(call HOST_FOLLOWUP)
endef
