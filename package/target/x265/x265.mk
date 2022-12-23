################################################################################
#
# x265
#
################################################################################

X265_VERSION = 3.5
X265_DIR = x265_$(X265_VERSION)
X265_SOURCE = x265_$(X265_VERSION).tar.gz
X265_SITE = https://bitbucket.org/multicoreware/x265_git/downloads

X265_SUBDIR  = source

X265_CONF_OPTS = \
	-DENABLE_CLI=OFF \
	-DENABLE_SHARED=ON \
	-DENABLE_PIC=ON

$(D)/x265: | bootstrap
	$(call cmake-package)
