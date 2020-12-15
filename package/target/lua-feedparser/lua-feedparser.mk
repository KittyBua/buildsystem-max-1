#
# lua-feedparser
#
LUA_FEEDPARSER_VER    = 0.71
LUA_FEEDPARSER_DIR    = lua-feedparser-$(LUA_FEEDPARSER_VER)
LUA_FEEDPARSER_SOURCE = lua-feedparser-$(LUA_FEEDPARSER_VER).tar.gz
LUA_FEEDPARSER_SITE   = $(call github,slact,lua-feedparser,$(LUA_FEEDPARSER_VER))

$(D)/lua-feedparser: bootstrap lua luasocket luaexpat
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		sed -i -e "s/^PREFIX.*//" -e "s/^LUA_DIR.*//" Makefile; \
		$(BUILD_ENV) \
		$(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(PKG_REMOVE)
	$(TOUCH)
