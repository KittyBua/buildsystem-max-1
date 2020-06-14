#
# luaposix
#
LUAPOSIX_VER    = 31
LUAPOSIX_DIR    = luaposix-$(LUAPOSIX_VER)
LUAPOSIX_SOURCE = luaposix-$(LUAPOSIX_VER).tar.gz
LUAPOSIX_GIT    = v$(LUAPOSIX_VER).tar.gz -O $(DL_DIR)/$(LUAPOSIX_SOURCE)
LUAPOSIX_URL    = https://github.com/luaposix/luaposix/archive

LUAPOSIX_PATCH   = \
	0001-fix-docdir-build.patch

$(D)/luaposix: bootstrap host-lua lua luaexpat slingshot gnulib
	$(START_BUILD)
	$(call DOWNLOAD,$(LUAPOSIX_GIT))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		tar -C gnulib --strip=1 -xf $(DL_DIR)/$(GNULIB_SOURCE); \
		tar -C slingshot --strip=1 -xf $(DL_DIR)/$(SLINGSHOT_SOURCE); \
		$(call apply_patches, $(PKG_PATCH)); \
		export LUA=$(HOST_LUA_BINARY); \
		./bootstrap $(SILENT_OPT); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--exec-prefix=/usr \
			--libdir=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVER) \
			--datarootdir=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER) \
			--mandir=$(TARGET_DIR)/.remove \
			--docdir=$(TARGET_DIR)/.remove \
			--enable-silent-rules \
			; \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
