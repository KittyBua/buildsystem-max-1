################################################################################
#
# hd-idle
#
################################################################################

HD_IDLE_VERSION = 1.05
HD_IDLE_DIR = hd-idle
HD_IDLE_SOURCE = hd-idle-$(HD_IDLE_VERSION).tgz
HD_IDLE_SITE = https://sourceforge.net/projects/hd-idle/files

HD_IDLE_DEPENDS = bootstrap

HD_IDLE_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV)

$(D)/hd-idle:
	$(call make-package)
