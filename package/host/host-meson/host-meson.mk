#
# host-meson
#
HOST_MESON_VER    = 0.54.2
HOST_MESON_DIR    = meson-$(HOST_MESON_VER)
HOST_MESON_SOURCE = meson-$(HOST_MESON_VER).tar.gz
HOST_MESON_SITE   = https://github.com/mesonbuild/meson/releases/download/$(HOST_MESON_VER)

HOST_MESON_PATCH  = \
	0001-Only-fix-RPATH-if-install_rpath-is-not-empty.patch \
	0002-Prefer-ext-static-libs-when-default-library-static.patch \
	0003-Allow-overriding-g-ir-scanner-and-g-ir-compiler-bina.patch \
	0004-mesonbuild-dependencies-base.py-add-pkg_config_stati.patch

$(D)/host-meson: bootstrap host-ninja host-python3 host-python3-setuptools
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(HOST_PYTHON_BUILD); \
		$(HOST_PYTHON_INSTALL)
	( \
		echo "[binaries]"; \
		echo "c = '$(TARGET_CROSS)gcc'"; \
		echo "cpp = '$(TARGET_CROSS)g++'"; \
		echo "ar = '$(TARGET_CROSS)ar'"; \
		echo "strip = '$(TARGET_STRIP)'"; \
		echo "pkgconfig = '$(HOST_DIR)/bin/$(TARGET)-pkg-config'"; \
		echo ""; \
		echo "[properties]"; \
		echo "c_args = '-I$(TARGET_INCLUDE_DIR)'"; \
		echo "c_link_args = '$(TARGET_LDFLAGS)'"; \
		echo "cpp_args = '-I$(TARGET_INCLUDE_DIR)'"; \
		echo "cpp_link_args = '$(TARGET_LDFLAGS)'"; \
		echo ""; \
		echo "[host_machine]"; \
		echo "system = 'linux'"; \
		echo "cpu_family = '$(TARGET_ARCH)'"; \
		echo "cpu = '$(TARGET_ARCH)'"; \
		echo "endian = '$(TARGET_ENDIAN)'" \
	) > $(HOST_DIR)/bin/meson-cross.config
	$(PKG_REMOVE)
	$(TOUCH)
