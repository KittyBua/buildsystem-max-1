#
# iozone
#
IOZONE_VER    = 3_489
IOZONE_DIR    = iozone$(IOZONE_VER)
IOZONE_SOURCE = iozone$(IOZONE_VER).tar
IOZONE_SITE   = http://www.iozone.org/src/current

$(D)/iozone: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		sed -i -e "s/= gcc/= $(TARGET_CC)/" src/current/makefile; \
		sed -i -e "s/= cc/= $(TARGET_CC)/" src/current/makefile; \
		cd src/current; \
		$(BUILD_ENV); \
		$(MAKE) linux-arm
		$(INSTALL_EXEC) $(PKG_BUILD_DIR)/src/current/iozone $(TARGET_DIR)/usr/bin
	$(PKG_REMOVE)
	$(TOUCH)
