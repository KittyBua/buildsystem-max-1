#
# readline
#
READLINE_VER    = 8.1
READLINE_DIR    = readline-$(READLINE_VER)
READLINE_SOURCE = readline-$(READLINE_VER).tar.gz
READLINE_SITE   = https://ftp.gnu.org/gnu/readline

READLINE_CONF_OPTS = \
	--datadir=$(REMOVE_datarootdir) \
	--disable-install-examples \
	bash_cv_func_sigsetjmp=yes \
	bash_cv_wcwidth_broken=no

$(D)/readline: bootstrap ncurses
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/inputrc $(TARGET_DIR)/etc/inputrc
	$(PKG_REMOVE)
	$(TOUCH)
