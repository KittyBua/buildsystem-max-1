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
	$(call PREPARE,$(1))
	$(call INDIVIDUAL)
	$(call TARGET_FOLLOWUP)
endef

define host-individual-package
	$(call PREPARE,$(1))
	$(call INDIVIDUAL)
	$(call HOST_FOLLOWUP)
endef
