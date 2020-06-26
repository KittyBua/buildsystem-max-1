#
# host-luarocks
#
HOST_LUAROCKS_VER    = 3.1.3
HOST_LUAROCKS_DIR    = luarocks-$(HOST_LUAROCKS_VER)
HOST_LUAROCKS_SOURCE = luarocks-$(HOST_LUAROCKS_VER).tar.gz
HOST_LUAROCKS_SITE   = https://luarocks.github.io/luarocks/releases
HOST_LUAROCKS_CONFIG = $(HOST_DIR)/etc/luarocks/config-$(LUA_ABIVER).lua
HOST_LUAROCKS_BINARY = $(HOST_DIR)/bin/luarocks

HOST_LUAROCKS_PATCH  = \
	0001-allow-libluajit-detection.patch

HOST_LUAROCKS_BUILD_ENV = \
	LUA_PATH="$(HOST_DIR)/share/lua/$(HOST_LUA_ABIVER)/?.lua" \
	TARGET_CC="$(TARGET_CC)" \
	TARGET_LD="$(TARGET_LD)" \
	TARGET_CFLAGS="$(TARGET_CFLAGS) -fPIC" \
	TARGET_LDFLAGS="-L$(TARGET_LIB_DIR)" \
	TARGET_DIR="$(TARGET_DIR)"

$(D)/host-luarocks: bootstrap host-lua
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		./configure $(SILENT_OPT) \
			--prefix=$(HOST_DIR) \
			--sysconfdir=$(HOST_DIR)/etc \
			--with-lua=$(HOST_DIR) \
			; \
		$(MAKE); \
		$(MAKE) install
	cat $(PKG_FILES_DIR)/luarocks-config.lua >> $(HOST_LUAROCKS_CONFIG)
	$(PKG_REMOVE)
	$(TOUCH)
