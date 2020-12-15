#
# rpcsvc-proto
#
RPCSVC_PROTO_VER    = 1.4
RPCSVC_PROTO_DIR    = rpcsvc-proto-$(RPCSVC_PROTO_VER)
RPCSVC_PROTO_SOURCE = rpcsvc-proto-$(RPCSVC_PROTO_VER).tar.xz
RPCSVC_PROTO_SITE   = https://github.com/thkukuk/rpcsvc-proto/releases/download/v$(RPCSVC_PROTO_VER)

RPCSVC_PROTO_PATCH = \
	0001-Use-cross-compiled-rpcgen.patch

$(D)/rpcsvc-proto: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
