################################################################################
#
# streamripper
#
################################################################################

STREAMRIPPER_VERSION = git
STREAMRIPPER_DIR     = ni-streamripper.git
STREAMRIPPER_SOURCE  = ni-streamripper.git
STREAMRIPPER_SITE    = https://github.com/neutrino-images
STREAMRIPPER_DEPENDS = bootstrap libvorbisidec libmad glib2

STREAMRIPPER_AUTORECONF = YES

STREAMRIPPER_CONF_OPTS = \
	--with-ogg-includes=${TARGET_INCLUDE_DIR} \
	--with-ogg-libraries=${TARGET_LIB_DIR} \
	--with-vorbis-includes=${TARGET_INCLUDE_DIR} \
	--with-vorbis-libraries=${TARGET_LIB_DIR} \
	--with-included-argv=yes \
	--with-included-libmad=no

define STREAMRIPPER_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/streamripper.sh $(TARGET_DIR)/bin/
endef
STREAMRIPPER_POST_INSTALL_HOOKS += STREAMRIPPER_INSTALL_FILES

$(D)/streamripper:
	$(call make-package)
