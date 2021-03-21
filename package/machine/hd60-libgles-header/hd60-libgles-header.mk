#
# hd60-libgles-header
#
HD60_LIBGLES_HEADER_VERSION = 6.2
HD60_LIBGLES_HEADER_SOURCE  = libgles-mali-utgard-headers.zip
HD60_LIBGLES_HEADER_SITE    = https://github.com/HD-Digital/meta-gfutures/raw/release-6.2/recipes-bsp/mali/files
HD60_LIBGLES_HEADER_DEPENDS = bootstrap

$(D)/hd60-libgles-header:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_INCLUDE_DIR))
	$(TOUCH)
