#
# libdpf
#
LIBDPF_VER    = git
LIBDPF_DIR    = dpf-ax.git
LIBDPF_SOURCE = dpf-ax.git
LIBDPF_SITE   = $(MAX-GIT-GITHUB)

LIBDPF_PATCH  = \
	0001-crossbuild.patch

$(D)/libdpf: bootstrap libusb-compat
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		make -C dpflib libdpf.a CC=$(TARGET_CC) PREFIX=$(TARGET_DIR)/usr; \
		mkdir -p $(TARGET_INCLUDE_DIR)/libdpf; \
		cp dpflib/dpf.h $(TARGET_INCLUDE_DIR)/libdpf/libdpf.h; \
		cp dpflib/libdpf.a $(TARGET_LIB_DIR)/; \
		cp include/usbuser.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp include/spiflash.h $(TARGET_INCLUDE_DIR)/libdpf/
	$(PKG_REMOVE)
	$(TOUCH)
