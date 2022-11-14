################################################################################
#
# sshfs
#
################################################################################

SSHFS_VERSION = 2.9
SSHFS_DIR = sshfs-$(SSHFS_VERSION)
SSHFS_SOURCE = sshfs-$(SSHFS_VERSION).tar.gz
SSHFS_SITE = https://github.com/libfuse/sshfs/releases/download/sshfs-$(SSHFS_VERSION)

SSHFS_DEPENDS = libglib2 libfuse

$(D)/sshfs: | bootstrap
	$(call autotools-package)
