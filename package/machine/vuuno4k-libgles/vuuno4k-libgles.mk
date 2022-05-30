################################################################################
#
# vuuno4k-libgles
#
################################################################################

VUUNO4K_LIBGLES_DATE    = $(VUUNO4K_DRIVER_DATE)
VUUNO4K_LIBGLES_REV     = r0
VUUNO4K_LIBGLES_VERSION = 17.1-$(VUUNO4K_LIBGLES_DATE).$(VUUNO4K_LIBGLES_REV)
VUUNO4K_LIBGLES_DIR     = libgles-vuuno4k
VUUNO4K_LIBGLES_SOURCE  = libgles-vuuno4k-$(VUUNO4K_LIBGLES_VERSION).tar.gz
VUUNO4K_LIBGLES_SITE    = http://code.vuplus.com/download/release/libgles
VUUNO4K_LIBGLES_DEPENDS = bootstrap

$(D)/vuuno4k-libgles:
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuuno4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuuno4k/include/* $(TARGET_INCLUDE_DIR)
	$(call TARGET_FOLLOWUP)
