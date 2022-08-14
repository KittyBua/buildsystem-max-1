################################################################################
#
# set up target environment for other makefiles
#
################################################################################

# Used by multilib code to change the library paths
baselib                = $(BASELIB)
BASELIB                = lib
BASELIB_powerpc64      = lib64

# Path prefixes
base_prefix            =
prefix                 = /usr
exec_prefix            = $(prefix)

root_prefix            = $(base_prefix)

# Base paths
base_bindir            = $(root_prefix)/bin
base_sbindir           = $(root_prefix)/sbin
base_libdir            = $(root_prefix)/$(baselib)
nonarch_base_libdir    = $(root_prefix)/lib

# Architecture independent paths
sysconfdir             = $(base_prefix)/etc
servicedir             = $(base_prefix)/srv
sharedstatedir         = $(base_prefix)/com
localstatedir          = $(base_prefix)/var
datadir                = $(prefix)/share
infodir                = $(datadir)/info
mandir                 = $(datadir)/man
docdir                 = $(datadir)/doc
nonarch_libdir         = $(exec_prefix)/lib
systemd_unitdir        = $(nonarch_base_libdir)/systemd
systemd_system_unitdir = $(nonarch_base_libdir)/systemd/system
systemd_user_unitdir   = $(nonarch_libdir)/systemd/user

# Architecture dependent paths
bindir                 = $(exec_prefix)/bin
sbindir                = $(exec_prefix)/sbin
libdir                 = $(exec_prefix)/$(baselib)
libexecdir             = $(exec_prefix)/libexec
includedir             = $(exec_prefix)/include
oldincludedir          = $(exec_prefix)/include
localedir              = $(libdir)/locale

# -----------------------------------------------------------------------------

TARGET_BASE_BIN_DIR    = $(TARGET_DIR)$(base_bindir)
TARGET_BASE_SBIN_DIR   = $(TARGET_DIR)$(base_sbindir)
TARGET_BASE_LIB_DIR    = $(TARGET_DIR)$(base_libdir)

TARGET_BIN_DIR         = $(TARGET_DIR)$(bindir)
TARGET_SBIN_DIR        = $(TARGET_DIR)$(sbindir)
TARGET_LIB_DIR         = $(TARGET_DIR)$(libdir)

TARGET_INCLUDE_DIR     = $(TARGET_DIR)$(includedir)
TARGET_LIBEXEC_DIR     = $(TARGET_DIR)$(libexecdir)
TARGET_SHARE_DIR       = $(TARGET_DIR)$(datadir)

TARGET_SYSCONF_DIR     = $(TARGET_DIR)$(sysconfdir)

TARGET_MODULES_DIR     = $(TARGET_DIR)/lib/modules/$(KERNEL_VERSION)
TARGET_FIRMWARE_DIR    = $(TARGET_BASE_LIB_DIR)/firmware

# -----------------------------------------------------------------------------

# 
REMOVE_dir             = /.remove
REMOVE_sysconfdir      = $(REMOVE_dir)/etc
REMOVE_bindir          = $(REMOVE_dir)$(bindir)
REMOVE_datarootdir     = $(REMOVE_dir)/share
REMOVE_docdir          = $(REMOVE_datarootdir)/doc
REMOVE_htmldir         = $(REMOVE_docdir)
REMOVE_infodir         = $(REMOVE_datarootdir)/info
REMOVE_localedir       = $(REMOVE_datarootdir)/locale
REMOVE_mandir          = $(REMOVE_datarootdir)/man

# -----------------------------------------------------------------------------

SHARE_NEUTRINO_FLEX      = $(TARGET_SHARE_DIR)/tuxbox/neutrino/flex
SHARE_NEUTRINO_ICONS     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/icons
SHARE_NEUTRINO_LCD4LINUX = $(TARGET_SHARE_DIR)/tuxbox/neutrino/lcd/icons
SHARE_NEUTRINO_LOGOS     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/icons/logo
SHARE_NEUTRINO_PLUGINS   = $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins
SHARE_NEUTRINO_THEMES    = $(TARGET_SHARE_DIR)/tuxbox/neutrino/themes
SHARE_NEUTRINO_WEBRADIO  = $(TARGET_SHARE_DIR)/tuxbox/neutrino/webradio
SHARE_NEUTRINO_WEBTV     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/webtv
VAR_NEUTRINO_CONFIG      = $(TARGET_DIR)/var/tuxbox/config
VAR_NEUTRINO_PLUGINS     = $(TARGET_DIR)/var/tuxbox/plugins

$(SHARE_NEUTRINO_FLEX) \
$(SHARE_NEUTRINO_ICONS) \
$(SHARE_NEUTRINO_LCD4LINUX) \
$(SHARE_NEUTRINO_LOGOS) \
$(SHARE_NEUTRINO_PLUGINS) \
$(SHARE_NEUTRINO_THEMES) \
$(SHARE_NEUTRINO_WEBRADIO) \
$(SHARE_NEUTRINO_WEBTV) \
$(VAR_NEUTRINO_CONFIG) \
$(VAR_NEUTRINO_PLUGINS):
	mkdir -p $(@)
