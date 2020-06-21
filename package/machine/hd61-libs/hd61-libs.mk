#
# hd61-libs
#
HD61_LIBS_DATE   = 20190120
HD61_LIBS_VER    = $(HD61_LIBS_DATE)
HD61_LIBS_SOURCE = hd61-libs-$(HD61_LIBS_VER).zip
HD61_LIBS_SITE   = http://downloads.mutant-digital.net/hd61

$(D)/hd61-libs: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/hiplay
	mkdir -p $(TARGET_DIR)/usr/lib/hisilicon
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(BUILD_DIR)/hiplay
	mkdir -p $(TARGET_DIR)/usr/lib/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/hisilicon/* $(TARGET_DIR)/usr/lib/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/ffmpeg/* $(TARGET_DIR)/usr/lib/hisilicon
	ln -sf /lib/ld-linux-armhf.so.3 $(TARGET_DIR)/usr/lib/hisilicon/ld-linux.so
	$(REMOVE)/hiplay
	$(TOUCH)
