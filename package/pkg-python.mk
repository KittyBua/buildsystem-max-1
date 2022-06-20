################################################################################
#
# Python package infrastructure
#
################################################################################

PYTHON_BUILD = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_SITEPACKAGES_DIR) \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_PYTHON_BINARY) ./setup.py -q build --executable=/usr/bin/python

PYTHON_INSTALL = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_SITEPACKAGES_DIR) \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_PYTHON_BINARY) ./setup.py -q install --root=$(TARGET_DIR) --prefix=/usr

define python-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Python3 package infrastructure
#
################################################################################

HOST_PYTHON3_BUILD = \
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_SITEPACKAGES_DIR) \
	$(HOST_PYTHON3_BINARY) ./setup.py -q build --executable=/usr/python

HOST_PYTHON3_INSTALL = \
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_SITEPACKAGES_DIR) \
	$(HOST_PYTHON3_BINARY) ./setup.py -q install --root=$(HOST_DIR) --prefix=

define host-python3-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(HOST_PYTHON3_BUILD); \
		$(HOST_PYTHON3_INSTALL)
	$(call HOST_FOLLOWUP)
endef
