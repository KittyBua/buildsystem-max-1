#
# hd60-libs
#
HD60_LIBS_DATE   = 20190120
HD60_LIBS_VER    = $(HD60_LIBS_DATE)
HD60_LIBS_SOURCE = hd60-libs-$(HD60_LIBS_VER).zip
HD60_LIBS_SITE   = http://downloads.mutant-digital.net/hd60

$(D)/hd60-libs: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/hiplay
	mkdir -p $(TARGET_DIR)/usr/lib/hisilicon
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(BUILD_DIR)/hiplay
	mkdir -p $(TARGET_DIR)/usr/lib/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/hisilicon/* $(TARGET_DIR)/usr/lib/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/ffmpeg/* $(TARGET_DIR)/usr/lib/hisilicon
	ln -sf /lib/ld-linux-armhf.so.3 $(TARGET_DIR)/usr/lib/hisilicon/ld-linux.so
	$(REMOVE)/hiplay
	$(TOUCH)
