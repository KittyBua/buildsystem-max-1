#
# vuuno4kse-libgles
#
VUUNO4KSE_LIBGLES_DATE    = $(VUUNO4KSE_DRIVER_DATE)
VUUNO4KSE_LIBGLES_REV     = r0
VUUNO4KSE_LIBGLES_VERSION = 17.1-$(VUUNO4KSE_LIBGLES_DATE).$(VUUNO4KSE_LIBGLES_REV)
VUUNO4KSE_LIBGLES_DIR     = libgles-vuuno4kse
VUUNO4KSE_LIBGLES_SOURCE  = libgles-vuuno4kse-$(VUUNO4KSE_LIBGLES_VERSION).tar.gz
VUUNO4KSE_LIBGLES_SITE    = http://code.vuplus.com/download/release/libgles
VUUNO4KSE_LIBGLES_DEPENDS = bootstrap

$(D)/vuuno4kse-libgles:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuuno4kse/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuuno4kse/include/* $(TARGET_INCLUDE_DIR)
	$(REMOVE)
	$(TOUCH)
