#
# expat
#
EXPAT_VER    = 2.2.10
EXPAT_DIR    = expat-$(EXPAT_VER)
EXPAT_SOURCE = expat-$(EXPAT_VER).tar.xz
EXPAT_SITE   = https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(EXPAT_VER))
EXPAT_DEPS   = bootstrap

EXPAT_AUTORECONF = YES

EXPAT_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--without-xmlwf \
	--without-docbook

$(D)/expat:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
