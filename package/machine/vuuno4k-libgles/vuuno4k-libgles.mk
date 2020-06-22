#
# vuuno4k-libgles
#
VUUNO4K_LIBGLES_DATE   = $(VUUNO4K_DRIVER_DATE)
VUUNO4K_LIBGLES_REV    = r0
VUUNO4K_LIBGLES_VER    = 17.1-$(VUUNO4K_LIBGLES_DATE).$(VUUNO4K_LIBGLES_REV)
VUUNO4K_LIBGLES_SOURCE = libgles-vuuno4k-$(VUUNO4K_LIBGLES_VER).tar.gz
VUUNO4K_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuuno4k-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/libgles-vuuno4k
	$(PKG_UNPACK)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuuno4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuuno4k/include/* $(TARGET_INCLUDE_DIR)
	$(REMOVE)/libgles-vuuno4k
	$(TOUCH)
