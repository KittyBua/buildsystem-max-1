#
# lua-feedparser
#
LUA_FEEDPARSER_VER    = 0.71
LUA_FEEDPARSER_DIR    = lua-feedparser-$(LUA_FEEDPARSER_VER)
LUA_FEEDPARSER_SOURCE = lua-feedparser-$(LUA_FEEDPARSER_VER).tar.gz
LUA_FEEDPARSER_GIT    = $(LUA_FEEDPARSER_VER).tar.gz -O $(DL_DIR)/$(LUA_FEEDPARSER_SOURCE)
LUA_FEEDPARSER_URL    = https://github.com/slact/lua-feedparser/archive

$(D)/lua-feedparser: bootstrap lua luasocket luaexpat
	$(START_BUILD)
	$(call DOWNLOAD,$(LUA_FEEDPARSER_GIT))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		sed -i -e "s/^PREFIX.*//" -e "s/^LUA_DIR.*//" Makefile ; \
		$(BUILD_ENV) $(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
