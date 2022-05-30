################################################################################
#
# fribidi
#
################################################################################

FRIBIDI_VERSION = 1.0.12
FRIBIDI_DIR     = fribidi-$(FRIBIDI_VERSION)
FRIBIDI_SOURCE  = fribidi-$(FRIBIDI_VERSION).tar.xz
FRIBIDI_SITE    = https://github.com/fribidi/fribidi/releases/download/v$(FRIBIDI_VERSION)
FRIBIDI_DEPENDS = bootstrap

FRIBIDI_CONF_OPTS = \
	--enable-shared \
	--enable-static \
	--disable-debug \
	--disable-deprecated

define FRIBIDI_CLEANUP_TARGET
	cd $(TARGET_DIR) && rm usr/bin/fribidi
endef
FRIBIDI_CLEANUP_TARGET_HOOKS += FRIBIDI_CLEANUP_TARGET

$(D)/fribidi:
	$(call make-package)
