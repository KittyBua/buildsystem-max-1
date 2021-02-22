#
# rpcsvc-proto
#
RPCSVC_PROTO_VER    = 1.4
RPCSVC_PROTO_DIR    = rpcsvc-proto-$(RPCSVC_PROTO_VER)
RPCSVC_PROTO_SOURCE = rpcsvc-proto-$(RPCSVC_PROTO_VER).tar.xz
RPCSVC_PROTO_SITE   = https://github.com/thkukuk/rpcsvc-proto/releases/download/v$(RPCSVC_PROTO_VER)
RPCSVC_PROTO_DEPS   = bootstrap

RPCSVC_PROTO_AUTORECONF = YES

$(D)/rpcsvc-proto:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
