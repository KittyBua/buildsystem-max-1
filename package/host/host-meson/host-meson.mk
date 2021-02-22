#
# host-meson
#
HOST_MESON_VER    = 0.54.2
HOST_MESON_DIR    = meson-$(HOST_MESON_VER)
HOST_MESON_SOURCE = meson-$(HOST_MESON_VER).tar.gz
HOST_MESON_SITE   = https://github.com/mesonbuild/meson/releases/download/$(HOST_MESON_VER)
HOST_MESON_DEPS   = bootstrap host-ninja host-python3 host-python3-setuptools

$(D)/host-meson:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(HOST_PYTHON_BUILD); \
		$(HOST_PYTHON_INSTALL)
	( \
		echo "[binaries]"; \
		echo "c = '$(TARGET_CROSS)gcc'"; \
		echo "cpp = '$(TARGET_CROSS)g++'"; \
		echo "ar = '$(TARGET_CROSS)ar'"; \
		echo "strip = '$(TARGET_STRIP)'"; \
		echo "pkgconfig = '$(HOST_DIR)/bin/$(GNU_TARGET_NAME)-pkg-config'"; \
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
	) > $(HOST_DIR)/bin/meson-cross-config
	$(REMOVE)
	$(TOUCH)
