#
# nettle
#
NETTLE_VER    = 3.5.1
NETTLE_DIR    = nettle-$(NETTLE_VER)
NETTLE_SOURCE = nettle-$(NETTLE_VER).tar.gz
NETTLE_SITE   = https://ftp.gnu.org/gnu/nettle

$(D)/nettle: bootstrap gmp
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-documentation \
		        ; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
