################################################################################
#
# Make package infrastructure
#
################################################################################

TARGET_MAKE_ENV = \
	PATH=$(PATH)

define TARGET_MAKE
	@$(call MESSAGE,"Compiling")
	$(foreach hook,$($(PKG)_PRE_COMPILE_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$(MAKE) \
			$($(PKG)_MAKE_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_COMPILE_HOOKS),$(call $(hook))$(sep))
endef

define TARGET_MAKE_INSTALL
	@$(call MESSAGE,"Installing to target")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$(MAKE) install DESTDIR=$(TARGET_DIR) \
			$($(PKG)_INSTALL_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

define make-package
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call TARGET_MAKE))
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

define HOST_MAKE
	@$(call MESSAGE,"Compiling")
	$(foreach hook,$($(PKG)_PRE_COMPILE_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(HOST_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$(MAKE) \
			$($(PKG)_MAKE_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_COMPILE_HOOKS),$(call $(hook))$(sep))
endef

define HOST_MAKE_INSTALL
	@$(call MESSAGE,"Installing to host")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR)/$(1); \
		$(HOST_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$(MAKE) install \
			$($(PKG)_INSTALL_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

define host-make-package
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call HOST_MAKE))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call HOST_MAKE_INSTALL))
	$(call HOST_FOLLOWUP)
endef
