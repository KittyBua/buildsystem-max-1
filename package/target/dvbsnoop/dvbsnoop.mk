################################################################################
#
# dvbsnoop
#
################################################################################

DVBSNOOP_VERSION = git
DVBSNOOP_DIR = dvbsnoop.git
DVBSNOOP_SOURCE = dvbsnoop.git
DVBSNOOP_SITE = https://github.com/Duckbox-Developers

DVBSNOOP_DEPENDS = kernel

DVBSNOOP_CONF_OPTS = \
	--enable-silent-rules

$(D)/dvbsnoop: | bootstrap
	$(call autotools-package)
