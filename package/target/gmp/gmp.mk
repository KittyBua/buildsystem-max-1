#
# gmp
#
GMP_VER    = 6.1.2
GMP_DIR    = gmp-$(GMP_VER)
GMP_SOURCE = gmp-$(GMP_VER).tar.xz
GMP_URL    = https://gmplib.org/download/gmp

$(D)/gmp: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--infodir=/.remove \
			--enable-silent-rules \
		        ; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
