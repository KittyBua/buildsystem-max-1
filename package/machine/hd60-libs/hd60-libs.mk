#
# hd60-libs
#
HD60_LIBS_DATE   = 20190120
HD60_LIBS_VER    = $(HD60_LIBS_DATE)
HD60_LIBS_SOURCE = hd60-libs-$(HD60_LIBS_VER).zip
HD60_LIBS_SITE   = http://downloads.mutant-digital.net/hd60

$(D)/hd60-libs: bootstrap
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
