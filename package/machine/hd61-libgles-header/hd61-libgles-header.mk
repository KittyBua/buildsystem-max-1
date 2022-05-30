################################################################################
#
# hd61-libgles-header
#
################################################################################

HD61_LIBGLES_HEADER_VERSION = 6.2
HD61_LIBGLES_HEADER_SOURCE  = libgles-mali-utgard-headers.zip
HD61_LIBGLES_HEADER_SITE    = https://github.com/HD-Digital/meta-gfutures/raw/release-6.2/recipes-bsp/mali/files
HD61_LIBGLES_HEADER_DEPENDS = bootstrap

$(D)/hd61-libgles-header:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_INCLUDE_DIR))
	$(call TARGET_FOLLOWUP)
