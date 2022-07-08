################################################################################
#
# wireless-tools
#
################################################################################

WIRELESS_TOOLS_VERSION = 30
WIRELESS_TOOLS_DIR = wireless_tools.$(WIRELESS_TOOLS_VERSION)
WIRELESS_TOOLS_SOURCE = wireless_tools.$(WIRELESS_TOOLS_VERSION).pre9.tar.gz
WIRELESS_TOOLS_SITE = https://hewlettpackard.github.io/wireless-tools

WIRELESS_TOOLS_DEPENDS = bootstrap

WIRELESS_TOOLS_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS) -I."

WIRELESS_TOOLS_MAKE_INSTALL_OPTS = \
	PREFIX=$(TARGET_DIR)/usr \
	INSTALL_MAN=$(TARGET_DIR)$(REMOVE_mandir)

$(D)/wireless-tools:
	$(call generic-package)
