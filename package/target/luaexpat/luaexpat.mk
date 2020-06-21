#
# luaexpat
#
LUAEXPAT_VER    = 1.3.3
LUAEXPAT_DIR    = luaexpat-$(LUAEXPAT_VER)
LUAEXPAT_SOURCE = luaexpat-$(LUAEXPAT_VER).tar.gz
LUAEXPAT_GIT    = v$(LUAEXPAT_VER).tar.gz -O $(DL_DIR)/$(LUAEXPAT_SOURCE)
LUAEXPAT_SITE   = https://github.com/tomasguisasola/luaexpat/archive

$(D)/luaexpat: bootstrap lua expat
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(LUAEXPAT_GIT))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		sed -i 's|^EXPAT_INC=.*|EXPAT_INC= $(TARGET_INCLUDE_DIR)|' makefile; \
		sed -i 's|^CFLAGS =.*|& -L$(TARGET_LIB_DIR)|' makefile; \
		sed -i 's|^CC =.*|CC = $(TARGET_CC)|' makefile; \
		$(MAKE) \
			PREFIX=$(TARGET_DIR)/usr \
			LUA_SYS_VER=$(LUA_ABIVER) \
			; \
		$(MAKE) install \
			PREFIX=$(TARGET_DIR)/usr \
			LUA_SYS_VER=$(LUA_ABIVER)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
