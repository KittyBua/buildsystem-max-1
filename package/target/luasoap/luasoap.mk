#
# luasoap
#
LUASOAP_VER    = 3.0
LUASOAP_DIR    = luasoap-$(LUASOAP_VER)
LUASOAP_SOURCE = luasoap-$(LUASOAP_VER).tar.gz
LUASOAP_URL    = https://github.com/downloads/tomasguisasola/luasoap

LUASOAP_PATCH  = \
	0001-luasoap.patch

$(D)/luasoap: bootstrap lua luasocket luaexpat
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
