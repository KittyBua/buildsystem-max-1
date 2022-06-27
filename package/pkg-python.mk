################################################################################
#
# Python package infrastructure
#
################################################################################

TARGET_PYTHON_ENV = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_SITEPACKAGES_DIR)

define TARGET_PYTHON_BUILD
	@$(call MESSAGE,"Build for the target")
	$(foreach hook,$($(PKG)_PRE_INSTALL_TARGET_HOOKS),$(call $(hook))$(sep))
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(TARGET_PYTHON_ENV) \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
		$(HOST_PYTHON_BINARY) ./setup.py -q build --executable=/usr/bin/python \
		$(HOST_PYTHON3_OPTS)
endef

define TARGET_PYTHON_INSTALL
	@$(call MESSAGE,"Installing to target")
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(TARGET_PYTHON_ENV) \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
		$(HOST_PYTHON_BINARY) ./setup.py -q install --root=$(TARGET_DIR) --prefix=/usr \
		$(HOST_PYTHON3_OPTS)
endef

define target-python-package
	$(call PREPARE)
	$(call TARGET_PYTHON_BUILD)
	$(call TARGET_PYTHON_INSTALL)
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Python3 package infrastructure
#
################################################################################

HOST_PYTHON3_ENV = \
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_SITEPACKAGES_DIR)

define HOST_PYTHON3_BUILD
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(HOST_PYTHON3_ENV) \
		$(HOST_PYTHON3_BINARY) ./setup.py -q build --executable=/usr/python \
		$(HOST_PYTHON3_OPTS)
endef

define HOST_PYTHON3_INSTALL
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		$(HOST_PYTHON3_ENV) \
		$(HOST_PYTHON3_BINARY) ./setup.py -q install --root=$(HOST_DIR) --prefix= \
		$(HOST_PYTHON3_OPTS)
endef

define host-python3-package
	$(call PREPARE)
	$(call HOST_PYTHON3_BUILD)
	$(call HOST_PYTHON3_INSTALL)
	$(call HOST_FOLLOWUP)
endef
