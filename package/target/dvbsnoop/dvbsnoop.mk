################################################################################
#
# dvbsnoop
#
################################################################################

DVBSNOOP_VERSION = git
DVBSNOOP_DIR = dvbsnoop.git
DVBSNOOP_SOURCE = dvbsnoop.git
DVBSNOOP_SITE = https://github.com/Duckbox-Developers
DVBSNOOP_DEPENDS = bootstrap kernel

DVBSNOOP_CONF_OPTS = \
	--enable-silent-rules

$(D)/dvbsnoop:
	$(call autotools-package)
