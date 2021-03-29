#
# libdpf
#
LIBDPF_VERSION = git
LIBDPF_DIR     = dpf-ax.git
LIBDPF_SOURCE  = dpf-ax.git
LIBDPF_SITE    = $(MAX-GIT-GITHUB)
LIBDPF_DEPENDS = bootstrap libusb-compat

libdpf:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		make -C dpflib libdpf.a CC=$(TARGET_CC) PREFIX=$(TARGET_DIR)/usr; \
		mkdir -p $(TARGET_INCLUDE_DIR)/libdpf; \
		cp dpflib/dpf.h $(TARGET_INCLUDE_DIR)/libdpf/libdpf.h; \
		cp dpflib/libdpf.a $(TARGET_LIB_DIR)/; \
		cp include/usbuser.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp include/spiflash.h $(TARGET_INCLUDE_DIR)/libdpf/
	$(REMOVE)
	$(TOUCH)
