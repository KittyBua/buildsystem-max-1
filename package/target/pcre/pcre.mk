#
# pcre
#
PCRE_VER    = 8.39
PCRE_DIR    = pcre-$(PCRE_VER)
PCRE_SOURCE = pcre-$(PCRE_VER).tar.bz2
PCRE_SITE   = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VER)
PCRE_DEPS   = bootstrap

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
