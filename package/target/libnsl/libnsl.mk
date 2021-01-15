#
# libnsl
#
LIBNSL_VER    = 1.2.0
LIBNSL_DIR    = libnsl-$(LIBNSL_VER)
LIBNSL_SOURCE = libnsl-$(LIBNSL_VER).tar.gz
LIBNSL_SITE   = $(call github,thkukuk,libnsl,v$(LIBNSL_VER))
LIBNSL_DEPS   = bootstrap libtirpc

$(D)/libnsl:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/lib/libnsl.so.2* $(TARGET_DIR)/lib; \
	ln -sfv ../../lib/libnsl.so.2.0.0 $(TARGET_DIR)/usr/lib/libnsl.so
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
