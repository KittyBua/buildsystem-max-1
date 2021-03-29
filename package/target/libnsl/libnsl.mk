#
# libnsl
#
LIBNSL_VERSION = 1.2.0
LIBNSL_DIR     = libnsl-$(LIBNSL_VERSION)
LIBNSL_SOURCE  = libnsl-$(LIBNSL_VERSION).tar.gz
LIBNSL_SITE    = $(call github,thkukuk,libnsl,v$(LIBNSL_VERSION))
LIBNSL_DEPENDS = bootstrap libtirpc

LIBNSL_AUTORECONF = YES

libnsl:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/lib/libnsl.so.2* $(TARGET_DIR)/lib; \
	ln -sfv ../../lib/libnsl.so.2.0.0 $(TARGET_DIR)/usr/lib/libnsl.so
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
