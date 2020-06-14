#
# set up target environment for other makefiles
#
# -----------------------------------------------------------------------------

SHARE_FLEX     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/flex
SHARE_ICONS    = $(TARGET_SHARE_DIR)/tuxbox/neutrino/icons
SHARE_LOGOS    = $(TARGET_SHARE_DIR)/tuxbox/neutrino/icons/logo
SHARE_PLUGINS  = $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins
SHARE_THEMES   = $(TARGET_SHARE_DIR)/tuxbox/neutrino/themes
SHARE_WEBRADIO = $(TARGET_SHARE_DIR)/tuxbox/neutrino/webradio
SHARE_WEBTV    = $(TARGET_SHARE_DIR)/tuxbox/neutrino/webtv
VAR_CONFIG     = $(TARGET_DIR)/var/tuxbox/config
VAR_PLUGINS    = $(TARGET_DIR)/var/tuxbox/plugins

$(SHARE_FLEX) \
$(SHARE_ICONS) \
$(SHARE_PLUGINS) \
$(SHARE_THEMES) \
$(SHARE_WEBRADIO) \
$(SHARE_WEBTV) \
$(VAR_CONFIG) \
$(VAR_PLUGINS) : | $(TARGET_DIR)
	mkdir -p $(@)

# -----------------------------------------------------------------------------

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

# https://www.gnu.org/prep/standards/html_node/Directory-Variables.html
remove-dir             = /.remove
remove-bindir          = $(remove-dir)/bin
remove-sbindir         = $(remove-dir)/sbin
remove-libexecdir      = $(remove-dir)/libexec
remove-datarootdir     = $(remove-dir)/share
remove-datadir         = $(remove-datarootdir)
remove-sysconfdir      = $(remove-dir)/etc
remove-sharedstatedir  = $(remove-dir)/com
remove-localstatedir   = $(remove-dir)/var
remove-runstatedir     = $(remove-dir)/run
remove-includedir      = $(remove-dir)/include
remove-oldincludedir   = $(remove-includedir)
remove-docdir          = $(remove-datarootdir)/doc
remove-infodir         = $(remove-datarootdir)/info
remove-htmldir         = $(remove-docdir)
remove-dvidir          = $(remove-docdir)
remove-pdfdir          = $(remove-docdir)
remove-psdir           = $(remove-docdir)
remove-libdir          = $(remove-dir)/lib
remove-lispdir         = $(remove-datarootdir)/emacs/site-lisp
remove-localedir       = $(remove-datarootdir)/locale
remove-mandir          = $(remove-datarootdir)/man
remove-man1dir         = $(remove-mandir)/man1
remove-man2dir         = $(remove-mandir)/man2

# -----------------------------------------------------------------------------

# ca-certificates
CA_BUNDLE              = ca-certificates.crt
CA_BUNDLE_DIR          = /etc/ssl/certs
