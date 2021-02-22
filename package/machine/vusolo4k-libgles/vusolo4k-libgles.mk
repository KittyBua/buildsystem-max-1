#
# vusolo4k-libgles
#
VUSOLO4K_LIBGLES_DATE   = $(VUSOLO4K_DRIVER_DATE)
VUSOLO4K_LIBGLES_REV    = r0
VUSOLO4K_LIBGLES_VER    = 17.1-$(VUSOLO4K_LIBGLES_DATE).$(VUSOLO4K_LIBGLES_REV)
VUSOLO4K_LIBGLES_DIR    = libgles-vusolo4k
VUSOLO4K_LIBGLES_SOURCE = libgles-vusolo4k-$(VUSOLO4K_LIBGLES_VER).tar.gz
VUSOLO4K_LIBGLES_SITE   = http://code.vuplus.com/download/release/libgles
VUSOLO4K_LIBGLES_DEPS   = bootstrap

$(D)/vusolo4k-libgles:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vusolo4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vusolo4k/include/* $(TARGET_INCLUDE_DIR)
	$(REMOVE)
	$(TOUCH)
