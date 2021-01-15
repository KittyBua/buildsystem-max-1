#
# libdpf
#
LIBDPF_VER    = git
LIBDPF_DIR    = dpf-ax.git
LIBDPF_SOURCE = dpf-ax.git
LIBDPF_SITE   = $(MAX-GIT-GITHUB)
LIBDPF_DEPS   = bootstrap libusb-compat

$(D)/libdpf:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		make -C dpflib libdpf.a CC=$(TARGET_CC) PREFIX=$(TARGET_DIR)/usr; \
		mkdir -p $(TARGET_INCLUDE_DIR)/libdpf; \
		cp dpflib/dpf.h $(TARGET_INCLUDE_DIR)/libdpf/libdpf.h; \
		cp dpflib/libdpf.a $(TARGET_LIB_DIR)/; \
		cp include/usbuser.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp include/spiflash.h $(TARGET_INCLUDE_DIR)/libdpf/
	$(PKG_REMOVE)
	$(TOUCH)
