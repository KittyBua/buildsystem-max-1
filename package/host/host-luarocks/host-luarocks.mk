################################################################################
#
# host-luarocks
#
################################################################################

HOST_LUAROCKS_VERSION = 3.9.0
HOST_LUAROCKS_DIR = luarocks-$(HOST_LUAROCKS_VERSION)
HOST_LUAROCKS_SOURCE = luarocks-$(HOST_LUAROCKS_VERSION).tar.gz
HOST_LUAROCKS_SITE = https://luarocks.github.io/luarocks/releases

HOST_LUAROCKS_DEPENDS = bootstrap host-lua

LUAROCKS_CONFIG_DIR  = $(HOST_DIR)/etc
HOST_LUAROCKS_CONFIG = $(LUAROCKS_CONFIG_DIR)/luarocks/config-$(LUA_ABIVERSION).lua
HOST_LUAROCKS_BINARY = $(HOST_DIR)/bin/luarocks

HOST_LUAROCKS_CONF_OPTS = \
	--sysconfdir=$(LUAROCKS_CONFIG_DIR) \
	--with-lua=$(HOST_DIR)

define HOST_LUAROCKS_REMOVE_CONFIG
	rm -f $(HOST_LUAROCKS_CONFIG)
endef
HOST_LUAROCKS_POST_PATCH_HOOKS += HOST_LUAROCKS_REMOVE_CONFIG

define HOST_LUAROCKS_CREATE_CONFIG
	cat $(PKG_FILES_DIR)/luarocks-config.lua >> $(HOST_LUAROCKS_CONFIG)
endef
HOST_LUAROCKS_POST_INSTALL_HOOKS += HOST_LUAROCKS_CREATE_CONFIG

$(D)/host-luarocks:
	$(call host-autotools-package)
