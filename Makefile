mac_pkgs := \
	alacritty \
	brew \
	dig \
	direnv \
	gem \
	gh \
	git \
	gnupg_mac \
	mpv \
	multipass \
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

mac_install:
	$(foreach mac_pkg,$(pkgs),$(call install,$(pkg)))

mac_uninstall:
	$(foreach mac_pkg,$(pkgs),$(call uninstall,$(pkg)))
