################################################################################
#
# hd-idle
#
################################################################################

HD_IDLE_VERSION = 1.05
HD_IDLE_DIR     = hd-idle
HD_IDLE_SOURCE  = hd-idle-$(HD_IDLE_VERSION).tgz
HD_IDLE_SITE    = https://sourceforge.net/projects/hd-idle/files
HD_IDLE_DEPENDS = bootstrap

$(D)/hd-idle:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_EMV) \
		$(MAKE); \
		$(MAKE) install TARGET_DIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
