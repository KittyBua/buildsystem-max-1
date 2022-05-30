################################################################################
#
# host-luarocks
#
################################################################################

HOST_LUAROCKS_VERSION = 3.1.3
HOST_LUAROCKS_DIR     = luarocks-$(HOST_LUAROCKS_VERSION)
HOST_LUAROCKS_SOURCE  = luarocks-$(HOST_LUAROCKS_VERSION).tar.gz
HOST_LUAROCKS_SITE    = https://luarocks.github.io/luarocks/releases
HOST_LUAROCKS_DEPENDS = bootstrap host-lua

HOST_LUAROCKS_CONFIG = $(HOST_DIR)/etc/luarocks/config-$(LUA_ABIVERSION).lua
HOST_LUAROCKS_BINARY = $(HOST_DIR)/bin/luarocks

HOST_LUAROCKS_CONF_OPTS = \
	--with-lua=$(HOST_DIR)

HOST_LUAROCKS_BUILD_ENV = \
	LUA_PATH="$(HOST_DIR)/share/lua/$(HOST_LUA_ABIVERSION)/?.lua" \
	TARGET_CC="$(TARGET_CC)" \
	TARGET_LD="$(TARGET_LD)" \
	TARGET_CFLAGS="$(TARGET_CFLAGS) -fPIC" \
	TARGET_LDFLAGS="-L$(TARGET_LIB_DIR)" \
	TARGET_DIR="$(TARGET_DIR)"

define HOST_LUAROCKS_DELETE_BEFORE_REBUILD
	rm -f $(HOST_LUAROCKS_CONFIG)
endef
HOST_LUAROCKS_POST_EXTRACT_HOOKS += HOST_LUAROCKS_DELETE_BEFORE_REBUILD

define HOST_LUAROCKS_INSTALL_FILES
	cat $(PKG_FILES_DIR)/luarocks-config.lua >> $(HOST_LUAROCKS_CONFIG)
endef
HOST_LUAROCKS_POST_INSTALL_HOOKS += HOST_LUAROCKS_INSTALL_FILES

$(D)/host-luarocks:
	$(call host-make-package)
