#
# pcre
#
PCRE_VERSION = 8.39
PCRE_DIR     = pcre-$(PCRE_VERSION)
PCRE_SOURCE  = pcre-$(PCRE_VERSION).tar.bz2
PCRE_SITE    = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VERSION)
PCRE_DEPENDS = bootstrap

PCRE_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-utf8 \
	--enable-unicode-properties

PCRE_CONFIG_SCRIPTS = pcre-config

$(D)/pcre:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG_SCRIPTS)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
