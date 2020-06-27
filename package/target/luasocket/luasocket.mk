#
# luasocket
#
LUASOCKET_VER    = git
LUASOCKET_DIR    = luasocket.git
LUASOCKET_SOURCE = luasocket.git
LUASOCKET_SITE   = git://github.com/diegonehab

$(D)/luasocket: bootstrap lua
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		sed -i -e "s@LD_linux=gcc@LD_LINUX=$(TARGET_CC)@" -e "s@CC_linux=gcc@CC_LINUX=$(TARGET_CC) -L$(TARGET_LIB_DIR)@" -e "s@DESTDIR?=@DESTDIR?=$(TARGET_DIR)/usr@" src/makefile; \
		$(MAKE) CC=$(TARGET)-gcc LD=$(TARGET)-gcc LUAV=$(LUA_ABIVER) PLAT=linux COMPAT=COMPAT LUAINC_linux=$(TARGET_INCLUDE_DIR) LUAPREFIX_linux=; \
		$(MAKE) install LUAPREFIX_linux= LUAV=$(LUA_ABIVER)
	$(PKG_REMOVE)
	$(TOUCH)
