################################################################################
#
# libiconv
#
################################################################################

LIBICONV_VERSION = 1.13.1
LIBICONV_DIR = libiconv-$(LIBICONV_VERSION)
LIBICONV_SOURCE = libiconv-$(LIBICONV_VERSION).tar.gz
LIBICONV_SITE = https://ftp.gnu.org/gnu/libiconv

LIBICONV_DEPENDS = bootstrap

LIBICONV_CONF_ENV = \
	CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC"

LIBICONV_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--localedir=$(REMOVE_localedir) \
	--enable-static \
	--disable-shared \
	--enable-relocatable

define LIBICONV_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_LIB_DIR)/,preloadable_libiconv.so)
endef
LIBICONV_TARGET_CLEANUP_HOOKS += LIBICONV_TARGET_CLEANUP

$(D)/libiconv:
	$(call autotools-package)
