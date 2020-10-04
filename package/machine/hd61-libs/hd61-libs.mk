#
# hd61-libs
#
HD61_LIBS_DATE   = 20200622
HD61_LIBS_VER    = $(HD61_LIBS_DATE)
HD61_LIBS_SOURCE = hd61-libs-$(HD61_LIBS_VER).zip
HD61_LIBS_SITE   = http://downloads.mutant-digital.net/hd61

$(D)/hd61-libs: bootstrap
	$(START_BUILD)
	$(REMOVE)/hiplay
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR)/hiplay)
	mkdir -p $(TARGET_LIB_DIR)/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/hisilicon/* $(TARGET_LIB_DIR)/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/ffmpeg/* $(TARGET_LIB_DIR)/hisilicon
	ln -sf /lib/ld-linux-armhf.so.3 $(TARGET_LIB_DIR)/hisilicon/ld-linux.so
	$(REMOVE)/hiplay
	$(TOUCH)
