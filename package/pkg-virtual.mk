################################################################################
#
# Virtual package infrastructure
#
# - just to resolve dependencies and call $($(PKG)_INDIVIDUAL_HOOKS)
#
################################################################################

define virtual-package
	$(call individual-package,$(PKG_NO_DOWNLOAD) $(PKG_NO_EXTRACT) $(PKG_NO_PATCHES))
endef

################################################################################
#
# Host virtual package infrastructure
#
################################################################################

define host-virtual-package
	$(call host-individual-package,$(PKG_NO_DOWNLOAD) $(PKG_NO_EXTRACT) $(PKG_NO_PATCHES))
endef
