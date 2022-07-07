################################################################################
#
# zlib
#
################################################################################

ZLIB_VERSION = 1.2.11
ZLIB_DIR = zlib-$(ZLIB_VERSION)
ZLIB_SOURCE = zlib-$(ZLIB_VERSION).tar.xz
ZLIB_SITE = https://sourceforge.net/projects/libpng/files/zlib/$(ZLIB_VERSION)
ZLIB_DEPENDS = bootstrap

ZLIB_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV) \
	mandir=$(REMOVE_mandir) \
	./configure \
	--prefix=/usr \
	--shared \
	--uname=Linux; \

ZLIB_CONF_ENV = \
	mandir=$(REMOVE_mandir)

$(D)/zlib:
	$(call make-package)
