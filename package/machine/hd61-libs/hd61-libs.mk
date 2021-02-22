#
# hd61-libs
#
HD61_LIBS_DATE   = 20200622
HD61_LIBS_VER    = $(HD61_LIBS_DATE)
HD61_LIBS_DIR    = hiplay
HD61_LIBS_SOURCE = hd61-libs-$(HD61_LIBS_VER).zip
HD61_LIBS_SITE   = http://downloads.mutant-digital.net/hd61
HD61_LIBS_DEPS   = bootstrap

$(D)/hd61-libs:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(PKG_BUILD_DIR))
	mkdir -p $(TARGET_LIB_DIR)/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/hisilicon/* $(TARGET_LIB_DIR)/hisilicon
	$(INSTALL_EXEC) $(BUILD_DIR)/hiplay/ffmpeg/* $(TARGET_LIB_DIR)/hisilicon
	ln -sf /lib/ld-linux-armhf.so.3 $(TARGET_LIB_DIR)/hisilicon/ld-linux.so
	$(REMOVE)
	$(TOUCH)
