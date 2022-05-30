################################################################################
#
# Meson package infrastructure
#
################################################################################

define meson-cross-config
	mkdir -p $(1)
	( \
		echo "# Note: Buildsystems's and Meson's terminologies differ about the meaning"; \
		echo "# of 'build', 'host' and 'target':"; \
		echo "# - Buildsystems's 'host' is Meson's 'build'"; \
		echo "# - Buildsystems's 'target' is Meson's 'host'"; \
		echo ""; \
		echo "[binaries]"; \
		echo "c = '$(TARGET_CC)'"; \
		echo "cpp = '$(TARGET_CXX)'"; \
		echo "ar = '$(TARGET_AR)'"; \
		echo "strip = '$(TARGET_STRIP)'"; \
		echo "nm = '$(TARGET_NM)'"; \
		echo "pkgconfig = '$(PKG_CONFIG)'"; \
		echo ""; \
		echo "[built-in options]"; \
		echo "c_args = '$(TARGET_CFLAGS)'"; \
		echo "c_link_args = '$(TARGET_LDFLAGS)'"; \
		echo "cpp_args = '$(TARGET_CXXFLAGS)'"; \
		echo "cpp_link_args = '$(TARGET_LDFLAGS)'"; \
		echo "prefix = '$(prefix)'"; \
		echo ""; \
		echo "[properties]"; \
		echo "needs_exe_wrapper = true"; \
		echo "sys_root = '$(TARGET_DIR)'"; \
		echo "pkg_config_libdir = '$(PKG_CONFIG_LIBDIR)'"; \
		echo ""; \
		echo "[host_machine]"; \
		echo "system = 'linux'"; \
		echo "cpu_family = '$(TARGET_ARCH)'"; \
		echo "cpu = '$(TARGET_CPU)'"; \
		echo "endian = '$(TARGET_ENDIAN)'" \
	) > $(1)/meson-cross.config
endef

TARGET_MESON_CONFIGURE = \
	$(call meson-cross-config,$(PKG_BUILD_DIR)/build); \
	unset CC CXX CPP LD AR NM STRIP; \
	$($(PKG)_CONF_ENV) \
	$(HOST_MESON_BINARY) \
		--buildtype=release \
		--cross-file $(PKG_BUILD_DIR)/build/meson-cross.config \
		-Db_pie=false \
		-Dstrip=false \
		$($(PKG)_CONF_OPTS) \
		$(PKG_BUILD_DIR) $(PKG_BUILD_DIR)/build

TARGET_NINJA = \
	$(HOST_NINJA_BINARY) -C $(PKG_BUILD_DIR)/build

TARGET_NINJA_INSTALL = \
	DESTDIR=$(TARGET_DIR) \
	$(HOST_NINJA_BINARY) -C $(PKG_BUILD_DIR)/build install

define meson-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_MESON_CONFIGURE); \
		$(TARGET_NINJA); \
		$(TARGET_NINJA_INSTALL)
	$(call TARGET_FOLLOWUP)
endef

# -----------------------------------------------------------------------------

HOST_MESON_CONFIGURE = \
	unset CC CXX CPP LD AR NM STRIP; \
	PKG_CONFIG=/usr/bin/pkg-config \
	PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig \
	$($(PKG)_CONF_ENV) \
	$(HOST_MESON_BINARY) \
		--prefix=/ \
		--buildtype=release \
		$($(PKG)_CONF_OPTS) \
		$(PKG_BUILD_DIR) $(PKG_BUILD_DIR)/build

HOST_NINJA = \
	$(HOST_NINJA_BINARY) -C $(PKG_BUILD_DIR)/build

HOST_NINJA_INSTALL = \
	DESTDIR=$(HOST_DIR) \
	$(HOST_NINJA_BINARY) -C $(PKG_BUILD_DIR)/build install

define host-meson-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(HOST_MESON_CONFIGURE); \
		$(HOST_NINJA); \
		$(HOST_NINJA_INSTALL)
	$(call HOST_FOLLOWUP)
endef
