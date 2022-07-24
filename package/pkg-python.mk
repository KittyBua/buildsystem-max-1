################################################################################
#
# Python package infrastructure
#
################################################################################

PYTHON_OPTS = \
	$(if $(VERBOSE),,-q)

TARGET_PYTHON_ENV = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_SITEPACKAGES_DIR)

define PYTHON_BUILD_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(TARGET_PYTHON_ENV) \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
		$(HOST_PYTHON_BINARY) ./setup.py $(PYTHON_OPTS) build --executable=/usr/bin/python
endef

define PYTHON_BUILD
	@$(call MESSAGE,"Building")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_BUILD_CMDS)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define PYTHON_INSTALL_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(TARGET_PYTHON_ENV) \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
		$(HOST_PYTHON_BINARY) ./setup.py $(PYTHON_OPTS) install --root=$(TARGET_DIR) --prefix=/usr
endef

define PYTHON_INSTALL
	@$(call MESSAGE,"Installing")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_INSTALL_CMDS)
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

define python-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call PYTHON_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call PYTHON_INSTALL))
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Python3 package infrastructure
#
################################################################################

HOST_PYTHON3_OPTS = \
	$(if $(VERBOSE),,-q)

HOST_PYTHON3_ENV = \
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_SITEPACKAGES_DIR)

define HOST_PYTHON3_BUILD_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(HOST_PYTHON3_ENV) \
		$(HOST_PYTHON3_BINARY) ./setup.py $(HOST_PYTHON3_OPTS) build
endef

define HOST_PYTHON3_BUILD
	@$(call MESSAGE,"Building")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_BUILD_CMDS)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

define HOST_PYTHON3_INSTALL_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(HOST_PYTHON3_ENV) \
		$(HOST_PYTHON3_BINARY) ./setup.py $(HOST_PYTHON3_OPTS) install  --prefix=$(HOST_DIR)
endef

define HOST_PYTHON3_INSTALL
	@$(call MESSAGE,"Installing")
	$(foreach hook,$($(PKG)_PRE_INSTALL_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_INSTALL_CMDS)
	$(foreach hook,$($(PKG)_POST_INSTALL_HOOKS),$(call $(hook))$(sep))
endef

define host-python3-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call HOST_PYTHON3_BUILD))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call HOST_PYTHON3_INSTALL))
	$(call HOST_FOLLOWUP)
endef
