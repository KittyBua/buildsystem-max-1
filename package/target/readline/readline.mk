################################################################################
#
# readline
#
################################################################################

READLINE_VERSION = 8.1.2
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

define READLINE_INSTALL_FILES
	$(INSTALL_DATA) $(PKG_FILES_DIR)/inputrc $(TARGET_DIR)/etc/inputrc
endef
READLINE_POST_INSTALL_HOOKS += READLINE_INSTALL_FILES

$(D)/readline:
	$(call autotools-package)
