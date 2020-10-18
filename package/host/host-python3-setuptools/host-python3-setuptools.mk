#
# python3-setuptools
#
HOST_PYTHON3_SETUPTOOLS_VER    = 44.0.0
HOST_PYTHON3_SETUPTOOLS_DIR    = setuptools-$(HOST_PYTHON3_SETUPTOOLS_VER)
HOST_PYTHON3_SETUPTOOLS_SOURCE = setuptools-$(HOST_PYTHON3_SETUPTOOLS_VER).zip
HOST_PYTHON3_SETUPTOOLS_SITE   = https://files.pythonhosted.org/packages/b0/f3/44da7482ac6da3f36f68e253cb04de37365b3dba9036a3c70773b778b485

HOST_PYTHON3_SETUPTOOLS_PATCH = \
	0001-add-executable.patch \
	0002-change-shebang-to-python3.patch

$(D)/host-python3-setuptools: bootstrap host-python3
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(HOST_PYTHON_BUILD); \
		$(HOST_PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)
