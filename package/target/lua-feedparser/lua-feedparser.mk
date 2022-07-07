################################################################################
#
# lua-feedparser
#
################################################################################

LUA_FEEDPARSER_VERSION = 0.71
LUA_FEEDPARSER_DIR = lua-feedparser-$(LUA_FEEDPARSER_VERSION)
LUA_FEEDPARSER_SOURCE = lua-feedparser-$(LUA_FEEDPARSER_VERSION).tar.gz
LUA_FEEDPARSER_SITE = $(call github,slact,lua-feedparser,$(LUA_FEEDPARSER_VERSION))

LUA_FEEDPARSER_DEPENDS = bootstrap lua luasocket luaexpat

define LUA_FEEDPARSER_POST_PATCH
	$(SED) "s/^PREFIX.*//" -e "s/^LUA_DIR.*//" $(PKG_BUILD_DIR)/Makefile
endef
LUA_FEEDPARSER_POST_PATCH_HOOKS += LUA_FEEDPARSER_POST_PATCH

$(D)/lua-feedparser:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION)
	$(call TARGET_FOLLOWUP)
