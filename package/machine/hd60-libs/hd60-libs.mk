#
# hd60-libs
#
HD60_LIBS_DATE   = 20200622
HD60_LIBS_VER    = $(HD60_LIBS_DATE)
HD60_LIBS_DIR    = hiplay
HD60_LIBS_SOURCE = hd60-libs-$(HD60_LIBS_VER).zip
HD60_LIBS_SITE   = http://downloads.mutant-digital.net/hd60
HD60_LIBS_DEPS   = bootstrap

$(D)/hd60-libs:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(PKG_BUILD_DIR))
	mkdir -p $(TARGET_LIB_DIR)/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/hisilicon/* $(TARGET_LIB_DIR)/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/ffmpeg/* $(TARGET_LIB_DIR)/hisilicon
	ln -sf /lib/ld-linux-armhf.so.3 $(TARGET_LIB_DIR)/hisilicon/ld-linux.so
	$(REMOVE)
	$(TOUCH)
