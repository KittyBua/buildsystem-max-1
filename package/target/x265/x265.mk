################################################################################
#
# x265
#
################################################################################

X265_VERSION = git
X265_DIR = x265.git
X265_SOURCE = x265.git
X265_SITE = https://github.com/videolan

X265_SUBDIR  = source

X265_CONF_OPTS = \
	-DENABLE_CLI=OFF \
	-DENABLE_SHARED=ON \
	-DENABLE_PIC=ON

$(D)/x265: | bootstrap
	$(call cmake-package)
