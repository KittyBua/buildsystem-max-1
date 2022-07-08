################################################################################
#
# udpxy
#
################################################################################

UDPXY_VERSION = git
UDPXY_DIR = udpxy.git
UDPXY_SOURCE = udpxy.git
UDPXY_SITE = https://github.com/pcherenkov

UDPXY_DEPENDS = bootstrap

UDPXY_SUBDIR = chipmunk

UDPXY_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV)

UDPXY_MAKE_INSTALL_OPTS = \
	INSTALLROOT=$(TARGET_DIR)/usr \
	MANPAGE_DIR=$(TARGET_DIR)$(REMOVE_mandir)

$(D)/udpxy:
	$(call generic-package)