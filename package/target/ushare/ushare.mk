USHARE_VER    = 1.1a
USHARE_DIR    = ushare-uShare_v$(USHARE_VER)
USHARE_SOURCE = uShare_v$(USHARE_VER).tar.gz
USHARE_SITE   = https://github.com/GeeXboX/ushare/archive

USHARE_CONF_OPTS = \
	--prefix=/usr \
	--cross-compile \
	--cross-prefix=$(TARGET_CROSS) \
	--sysconfdir=/etc \
	--localedir=$(REMOVE_localedir) \
	--disable-dlna \
	--disable-nls

$(D)/ushare: bootstrap libupnp
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		./configure $(PKG_CONF_OPTS); \
		ln -sf ../config.h src/; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/ushare.conf $(TARGET_DIR)/etc/ushare.conf
	$(SED) 's|%(BOXTYPE)|$(BOXTYPE)|; s|%(BOXMODEL)|$(BOXMODEL)|' $(TARGET_DIR)/etc/ushare.conf
	$(INSTALL_EXEC) -D $(PKG_FILES_DIR)/ushare.init $(TARGET_DIR)/etc/init.d/ushare
	$(UPDATE-RC.D) ushare defaults 75 25
	$(PKG_REMOVE)
	$(TOUCH)
