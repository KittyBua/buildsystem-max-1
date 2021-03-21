#
# luasoap
#
LUASOAP_VERSION = 3.0
LUASOAP_DIR     = luasoap-$(LUASOAP_VERSION)
LUASOAP_SOURCE  = luasoap-$(LUASOAP_VERSION).tar.gz
LUASOAP_SITE    = https://github.com/downloads/tomasguisasola/luasoap
LUASOAP_DEPENDS = bootstrap lua luasocket luaexpat

$(D)/luasoap:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION)
	$(REMOVE)
	$(TOUCH)
