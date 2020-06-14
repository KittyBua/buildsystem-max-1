#
# vuuno4kse-libgles
#
VUUNO4KSE_LIBGLES_DATE   = $(VUUNO4KSE_DRIVER_DATE)
VUUNO4KSE_LIBGLES_REV    = r0
VUUNO4KSE_LIBGLES_VER    = 17.1-$(VUUNO4KSE_LIBGLES_DATE).$(VUUNO4KSE_LIBGLES_REV)
VUUNO4KSE_LIBGLES_SOURCE = libgles-vuuno4kse-$(VUUNO4KSE_LIBGLES_VER).tar.gz
VUUNO4KSE_LIBGLES_URL    = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuuno4kse-libgles: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/libgles-vuuno4kse
	$(UNTAR)/$(PKG_SOURCE)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuuno4kse/lib/* $(TARGET_DIR)/usr/lib
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuuno4kse/include/* $(TARGET_DIR)/usr/include
	$(REMOVE)/libgles-vuuno4kse
	$(TOUCH)
