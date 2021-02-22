#
# hd61-libgles-header
#
HD61_LIBGLES_HEADER_VER    =
HD61_LIBGLES_HEADER_SOURCE = libgles-mali-utgard-headers.zip
HD61_LIBGLES_HEADER_SITE   = https://github.com/HD-Digital/meta-gfutures/raw/release-6.2/recipes-bsp/mali/files
HD61_LIBGLES_HEADER_DEPS   = bootstrap

$(D)/hd61-libgles-header:
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(TARGET_INCLUDE_DIR))
	$(TOUCH)
