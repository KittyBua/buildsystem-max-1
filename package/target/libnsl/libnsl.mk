#
# libnsl
#
LIBNSL_VER    = 1.2.0
LIBNSL_DIR    = libnsl-$(LIBNSL_VER)
LIBNSL_SOURCE = libnsl-$(LIBNSL_VER).tar.gz
LIBNSL_GIT    = v$(LIBNSL_VER).tar.gz -O $(DL_DIR)/$(LIBNSL_SOURCE)
LIBNSL_SITE   = https://github.com/thkukuk/libnsl/archive

$(D)/libnsl: bootstrap libtirpc
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(LIBNSL_GIT))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--sysconfdir=/etc \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/lib/libnsl.so.2* $(TARGET_DIR)/lib; \
	ln -sfv ../../lib/libnsl.so.2.0.0 $(TARGET_DIR)/usr/lib/libnsl.so
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
