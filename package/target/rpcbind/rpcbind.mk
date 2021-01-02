#
# rpcbind
#
RPCBIND_VER    = 1.2.5
RPCBIND_DIR    = rpcbind-$(RPCBIND_VER)
RPCBIND_SOURCE = rpcbind-$(RPCBIND_VER).tar.bz2
RPCBIND_SITE   = https://sourceforge.net/projects/rpcbind/files/rpcbind/$(RPCBIND_VER)

RPCBIND_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) `$(PKG_CONFIG) --cflags libtirpc`" \
	--bindir=$(sbindir) \
	--enable-silent-rules \
	--with-rpcuser=root \
	--with-systemdsystemunitdir=no

$(D)/rpcbind: bootstrap libtirpc
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/rpc $(TARGET_DIR)/etc/rpc
	$(INSTALL_DATA) $(PKG_FILES_DIR)/rpcbind.conf $(TARGET_DIR)/etc/rpcbind.conf
ifeq ($(BS_INIT_SYSTEMD),y)
	$(INSTALL_DATA) $(PKG_FILES_DIR)rpcbind.service $(TARGET_DIR)/lib/systemd/system/rpcbind.service
	$(INSTALL_DATA) $(PKG_FILES_DIR)rpcbind.socket $(TARGET_DIR)/lib/systemd/system/rpcbind.socket
else
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/rpcbind.init $(TARGET_DIR)/etc/init.d/rpcbind
	$(UPDATE-RC.D) rpcbind start 12 2 3 4 5 . stop 60 0 1 6 .
endif
	$(PKG_REMOVE)
	$(TOUCH)
