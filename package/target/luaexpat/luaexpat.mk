#
# luaexpat
#
LUAEXPAT_VER    = 1.3.3
LUAEXPAT_DIR    = luaexpat-$(LUAEXPAT_VER)
LUAEXPAT_SOURCE = luaexpat-$(LUAEXPAT_VER).tar.gz
LUAEXPAT_SITE   = $(call github,tomasguisasola,luaexpat,v$(LUAEXPAT_VER))

$(D)/luaexpat: bootstrap lua expat
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
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
	$(PKG_REMOVE)
	$(TOUCH)
