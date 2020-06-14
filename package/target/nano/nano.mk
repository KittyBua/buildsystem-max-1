#
# nano
#
NANO_VER    = 2.2.6
NANO_DIR    = nano-$(NANO_VER)
NANO_SOURCE = nano-$(NANO_VER).tar.gz
NANO_URL    = https://www.nano-editor.org/dist/v$(basename $(NANO_VER))

$(D)/nano: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--infodir=/.remove \
			--localedir=/.remove/locale \
			--mandir=/.remove \
			--disable-nls \
			--enable-tiny \
			--enable-color \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
