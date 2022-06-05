################################################################################
#
# makefile for clean targets
#
################################################################################

%-clean:
	@printf "$(TERM_YELLOW)===> clean $(subst -clean,,$@) .. $(TERM_NORMAL)"
	$(shell find $(D) -name $(subst -clean,,$@) -delete)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

depsclean:
	$(shell find $(D) ! -name "*\.*" -delete )

clean: depsclean
	@printf "$(TERM_YELLOW)===> cleaning system build directories and files .. $(TERM_NORMAL)"
	@-rm -rf $(HOST_DIR)
	@-rm -rf $(RELEASE_DIR)
	@-rm -rf $(TARGET_DIR)
	@-rm -rf $(D)/kernel
	@-rm -rf $(D)/*.do_compile
	@-rm -rf $(D)/*.config.status
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

distclean:
	@printf "$(TERM_YELLOW)===> cleaning system build directories and files .. $(TERM_NORMAL)"
	@-rm -rf $(HOST_DIR)
	@-rm -rf $(RELEASE_DIR)
	@-rm -rf $(TARGET_DIR)
	@-rm -rf $(BUILD_DIR)
	@-rm -rf $(SOURCE_DIR)
	@-rm -rf $(D)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

# -----------------------------------------------------------------------------

PHONY += %-clean
PHONY += depsclean
PHONY += clean
PHONY += distclean
