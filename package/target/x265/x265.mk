################################################################################
#
# x265
#
################################################################################

X265_VERSION = git
X265_DIR     = x265.git
X265_SOURCE  = x265.git
X265_SITE    = https://github.com/videolan
X265_DEPENDS = bootstrap

X265_CONF_OPTS = \
	-DENABLE_CLI=OFF \
	-DENABLE_SHARED=ON \
	-DENABLE_PIC=ON

$(D)/x265:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR)/source; \
		$(TARGET_CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
