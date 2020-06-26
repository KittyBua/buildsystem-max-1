#
# portmap
#
PORTMAP_VER    = 6.0.0
PORTMAP_DIR    = portmap-$(PORTMAP_VER)
PORTMAP_SOURCE = portmap_$(PORTMAP_VER).orig.tar.gz
PORTMAP_DIFF   = portmap_$(PORTMAP_VER)-3.diff.gz
PORTMAP_SITE   = https://merges.ubuntu.com/p/portmap

PORTMAP_PATCH  = \
	0001-portmap.patch

$(D)/portmap: bootstrap lsb
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PORTMAP_DIFF))
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		gunzip -cd $(DL_DIR)/$(PORTMAP_DIFF) | cat > debian.patch; \
		patch -p1 $(SILENT_PATCH) <debian.patch && \
		sed -e 's/### BEGIN INIT INFO/# chkconfig: S 41 10\n### BEGIN INIT INFO/g' -i debian/init.d; \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) $(MAKE) NO_TCP_WRAPPER=1 DAEMON_UID=65534 DAEMON_GID=65535 CC="$(TARGET_CC)"; \
		$(INSTALL_EXEC) portmap $(TARGET_DIR)/sbin; \
		$(INSTALL_EXEC) pmap_dump $(TARGET_DIR)/sbin; \
		$(INSTALL_EXEC) pmap_set $(TARGET_DIR)/sbin; \
		$(INSTALL_EXEC) debian/init.d $(TARGET_DIR)/etc/init.d/portmap
	$(UPDATE-RC.D) portmap start 12 2 3 4 5 . stop 60 0 1 6 .
	$(PKG_REMOVE)
	$(TOUCH)
