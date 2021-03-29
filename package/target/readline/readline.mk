#
# readline
#
READLINE_VERSION = 8.1
READLINE_DIR     = readline-$(READLINE_VERSION)
READLINE_SOURCE  = readline-$(READLINE_VERSION).tar.gz
READLINE_SITE    = https://ftp.gnu.org/gnu/readline
READLINE_DEPENDS = bootstrap ncurses

READLINE_CONF_OPTS = \
	--datadir=$(REMOVE_datarootdir) \
	--docdir=$(REMOVE_docdir) \
	--disable-install-examples \
	bash_cv_func_sigsetjmp=yes \
	bash_cv_wcwidth_broken=no

readline:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/inputrc $(TARGET_DIR)/etc/inputrc
	$(REMOVE)
	$(TOUCH)
