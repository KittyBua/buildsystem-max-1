#
# hd61-libgles-header
#
HD61_LIBGLES_HEADER_VER    =
HD61_LIBGLES_HEADER_SOURCE = libgles-mali-utgard-headers.zip
HD61_LIBGLES_HEADER_SITE   = https://github.com/HD-Digital/meta-gfutures/raw/release-6.2/recipes-bsp/mali/files

$(D)/hd61-libgles-header: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(TARGET_INCLUDE_DIR))
	$(TOUCH)
