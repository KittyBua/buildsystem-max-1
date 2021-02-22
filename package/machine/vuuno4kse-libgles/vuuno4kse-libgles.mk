#
# vuuno4kse-libgles
#
VUUNO4KSE_LIBGLES_DATE   = $(VUUNO4KSE_DRIVER_DATE)
VUUNO4KSE_LIBGLES_REV    = r0
VUUNO4KSE_LIBGLES_VER    = 17.1-$(VUUNO4KSE_LIBGLES_DATE).$(VUUNO4KSE_LIBGLES_REV)
VUUNO4KSE_LIBGLES_VER    = libgles-vuuno4kse
VUUNO4KSE_LIBGLES_SOURCE = libgles-vuuno4kse-$(VUUNO4KSE_LIBGLES_VER).tar.gz
VUUNO4KSE_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus
VUUNO4KSE_LIBGLES_DEPS   = bootstrap

$(D)/vuuno4kse-libgles:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuuno4kse/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuuno4kse/include/* $(TARGET_INCLUDE_DIR)
	$(REMOVE)
	$(TOUCH)
