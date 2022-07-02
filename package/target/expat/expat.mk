################################################################################
#
# expat
#
################################################################################

EXPAT_VERSION = 2.4.8
EXPAT_DIR     = expat-$(EXPAT_VERSION)
EXPAT_SOURCE  = expat-$(EXPAT_VERSION).tar.xz
EXPAT_SITE    = https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(EXPAT_VERSION))
EXPAT_DEPENDS = bootstrap

EXPAT_AUTORECONF = YES

EXPAT_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--without-xmlwf \
	--without-docbook

define EXPAT_CLEANUP_TARGET
	rm -rf $(addprefix $(TARGET_LIB_DIR)/,cmake)
endef
EXPAT_CLEANUP_TARGET_HOOKS += EXPAT_CLEANUP_TARGET

$(D)/expat:
	$(call autotools-package)
