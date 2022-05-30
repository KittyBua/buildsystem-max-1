################################################################################
#
# fontconfig
#
################################################################################

FONTCONFIG_VERSION = 2.14.0
FONTCONFIG_DIR     = fontconfig-$(FONTCONFIG_VERSION)
FONTCONFIG_SOURCE  = fontconfig-$(FONTCONFIG_VERSION).tar.xz
FONTCONFIG_SITE    = https://www.freedesktop.org/software/fontconfig/release
FONTCONFIG_DEPENDS = bootstrap freetype expat

FONTCONFIG_CONF_OPTS = \
	--bindir=$(REMOVE_bindir) \
	--sysconfdir=$(REMOVE_sysconfdir) \
	--localedir=$(REMOVE_localedir) \
	--with-freetype-config=$(HOST_DIR)/bin/freetype-config \
	--with-expat-includes=$(TARGET_INCLUDE_DIR) \
	--with-expat-lib=$(TARGET_LIB_DIR) \
	--disable-docs

define FONTCONFIG_CLEANUP_TARGET
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,fontconfig gettext xml)
endef
FONTCONFIG_CLEANUP_TARGET_HOOKS += FONTCONFIG_CLEANUP_TARGET

$(D)/fontconfig:
	$(call make-package)
