################################################################################
#
# rpcsvc-proto
#
################################################################################

RPCSVC_PROTO_VERSION = 1.4
RPCSVC_PROTO_DIR     = rpcsvc-proto-$(RPCSVC_PROTO_VERSION)
RPCSVC_PROTO_SOURCE  = rpcsvc-proto-$(RPCSVC_PROTO_VERSION).tar.xz
RPCSVC_PROTO_SITE    = https://github.com/thkukuk/rpcsvc-proto/releases/download/v$(RPCSVC_PROTO_VERSION)
RPCSVC_PROTO_DEPENDS = bootstrap

RPCSVC_PROTO_AUTORECONF = YES

$(D)/rpcsvc-proto:
	$(call autotools-package)
