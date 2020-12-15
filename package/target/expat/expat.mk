#
# expat
#
EXPAT_VER    = 2.2.10
EXPAT_DIR    = expat-$(EXPAT_VER)
EXPAT_SOURCE = expat-$(EXPAT_VER).tar.xz
EXPAT_SITE   = https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(EXPAT_VER))

EXPAT_PATCH = \
	0001-libtool-tag.patch

EXPAT_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--without-xmlwf \
	--without-docbook

$(D)/expat: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
