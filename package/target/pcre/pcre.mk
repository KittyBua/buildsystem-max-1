################################################################################
#
# pcre
#
################################################################################

PCRE_VERSION = 8.39
PCRE_DIR     = pcre-$(PCRE_VERSION)
PCRE_SOURCE  = pcre-$(PCRE_VERSION).tar.bz2
PCRE_SITE    = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VERSION)
PCRE_DEPENDS = bootstrap

PCRE_CONFIG_SCRIPTS = pcre-config

PCRE_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-utf8 \
	--enable-unicode-properties

$(D)/pcre:
	$(call autotools-package)
