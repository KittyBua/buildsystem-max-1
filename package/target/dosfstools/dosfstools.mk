################################################################################
#
# dosfstools
#
################################################################################

DOSFSTOOLS_VERSION = 4.2
DOSFSTOOLS_DIR = dosfstools-$(DOSFSTOOLS_VERSION)
DOSFSTOOLS_SOURCE = dosfstools-$(DOSFSTOOLS_VERSION).tar.gz
DOSFSTOOLS_SITE = https://github.com/dosfstools/dosfstools/releases/download/v$(DOSFSTOOLS_VERSION)

DOSFSTOOLS_AUTORECONF = YES

DOSFSTOOLS_CONF_OPTS = \
	--sbindir=$(base_sbindir) \
	--docdir=$(REMOVE_docdir) \
	--without-iconv \
	--enable-compat-symlinks

$(D)/dosfstools: | bootstrap
	$(call autotools-package)
