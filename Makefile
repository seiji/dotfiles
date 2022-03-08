pkgs := brew \
				cvim \
				dig \
				direnv \
				gem \
				gh \
				git \
				gnupg \
				navi \
				nvim \
				terraform \
				tig \
				tmux \
				zsh

define install
	stow -S -t ${HOME} -v $(1)

endef

define uninstall
	stow -D -t ${HOME} -v $(1)

endef

install:
	$(foreach pkg,$(pkgs),$(call install,$(pkg)))

uninstall:
	$(foreach pkg,$(pkgs),$(call uninstall,$(pkg)))
