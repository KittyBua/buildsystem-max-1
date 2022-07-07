################################################################################
#
# gmp
#
################################################################################

GMP_VERSION = 6.2.1
GMP_DIR = gmp-$(GMP_VERSION)
GMP_SOURCE = gmp-$(GMP_VERSION).tar.xz
GMP_SITE = https://gmplib.org/download/gmp

GMP_DEPENDS = bootstrap

GMP_CONF_OPTS = \
	--enable-silent-rules

$(D)/gmp:
	$(call autotools-package)
