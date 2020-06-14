#
# python3-setuptools
#
HOST_PYTHON3_SETUPTOOLS_VER    = 44.0.0
HOST_PYTHON3_SETUPTOOLS_DIR    = setuptools-$(HOST_PYTHON3_SETUPTOOLS_VER)
HOST_PYTHON3_SETUPTOOLS_SOURCE = setuptools-$(HOST_PYTHON3_SETUPTOOLS_VER).zip
HOST_PYTHON3_SETUPTOOLS_URL    = https://files.pythonhosted.org/packages/b0/f3/44da7482ac6da3f36f68e253cb04de37365b3dba9036a3c70773b778b485

HOST_PYTHON3_SETUPTOOLS_PATCH = \
	0001-add-executable.patch

$(D)/host-python3-setuptools: bootstrap host-python3
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(BUILD_DIR)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(HOST_PYTHON_BUILD); \
		$(HOST_PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
