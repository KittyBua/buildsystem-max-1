################################################################################
#
# read-edid
#
################################################################################

READ_EDID_VERSION = 3.0.2
READ_EDID_DIR = read-edid-$(READ_EDID_VERSION)
READ_EDID_SOURCE = read-edid-$(READ_EDID_VERSION).tar.gz
READ_EDID_SITE = http://www.polypux.org/projects/read-edid

READ_EDID_CONF_OPTS = \
	-DCLASSICBUILD=OFF

$(D)/read-edid: | bootstrap
	$(call cmake-package)
