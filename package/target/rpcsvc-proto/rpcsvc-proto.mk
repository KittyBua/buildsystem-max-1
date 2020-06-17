#
# rpcsvc-proto
#
RPCSVC_PROTO_VER    = 1.4
RPCSVC_PROTO_DIR    = rpcsvc-proto-$(RPCSVC_PROTO_VER)
RPCSVC_PROTO_SOURCE = rpcsvc-proto-$(RPCSVC_PROTO_VER).tar.xz
RPCSVC_PROTO_SITE   = https://github.com/thkukuk/rpcsvc-proto/releases/download/v$(RPCSVC_PROTO_VER)

RPCSVC_PROTO_PATCH  = \
	0001-Use-cross-compiled-rpcgen.patch

$(D)/rpcsvc-proto: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--sysconfdir=/etc \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
