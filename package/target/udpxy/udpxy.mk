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

$(D)/udpxy:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) -C chipmunk; \
		$(MAKE) -C chipmunk install INSTALLROOT=$(TARGET_DIR)/usr MANPAGE_DIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(call TARGET_FOLLOWUP)