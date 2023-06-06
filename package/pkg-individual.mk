################################################################################
#
# Individual package infrastructure
#
################################################################################

define INDIVIDUAL
	@$(call MESSAGE,"Individual build and/or install")
	$(foreach hook,$($(PKG)_INDIVIDUAL_HOOKS),$(call $(hook))$(sep))
endef

define individual-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $($(PKG)_INDIVIDUAL_HOOKS),$(call INDIVIDUAL))
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Host individual package infrastructure
#
################################################################################

define host-individual-package
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(if $($(PKG)_INDIVIDUAL_HOOKS),$(call INDIVIDUAL))
	$(call HOST_FOLLOWUP)
endef
