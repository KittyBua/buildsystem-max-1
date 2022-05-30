################################################################################
#
# WAF package infrastructure
#
################################################################################

WAF_CONFIGURE_OPTIONS = \
	--target=$(GNU_TARGET_NAME) \
	--prefix=$(prefix) \
	--exec-prefix=$(exec_prefix) \
	--bindir=$(bindir) \
	--datadir=$(datadir) \
	--includedir=$(includedir) \
	--libdir=$(libdir) \
	--mandir=$(REMOVE_mandir) \
	--datarootdir=$(datadir) \
	--sysconfdir=$(sysconfdir) \
	$($(PKG)_CONF_OPTS)

define waf-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) configure \
		$(WAF_CONFIGURE_OPTIONS) \
		$($(PKG)_CONF_OPTS); \
		$(TARGET_MAKE_ENV) $(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) build -j $(PARALLEL_JOBS); \
		$(TARGET_MAKE_ENV) $(HOST_PYTHON3_BINARY) $(HOST_WAF_BINARY) install --destdir=$(TARGET_DIR)
	$(call HOST_FOLLOWUP)
endef
