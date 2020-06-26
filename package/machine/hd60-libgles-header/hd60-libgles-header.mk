#
# hd60-libgles-header
#
HD60_LIBGLES_HEADER_VER    = 6.2
HD60_LIBGLES_HEADER_SOURCE = libgles-mali-utgard-headers.zip
HD60_LIBGLES_HEADER_SITE   = https://github.com/HD-Digital/meta-gfutures/raw/release-6.2/recipes-bsp/mali/files

$(D)/hd60-libgles-header: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(TARGET_INCLUDE_DIR))
	$(TOUCH)
