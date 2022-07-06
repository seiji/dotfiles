pkgs := \
	alacritty \
	dig \
	direnv \
	gem \
	gh \
	git \
	gnupg \
	mpv \
	navi \
	nvim \
	terraform \
	tig \
	tmux \
	zsh

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

install:
	$(foreach pkg,$(pkgs),$(call install,$(pkg)))

uninstall:
	$(foreach pkg,$(pkgs),$(call uninstall,$(pkg)))

mac_install:
	$(foreach pkg,$(mac_pkgs),$(call install,$(pkg)))

mac_uninstall:
	$(foreach pkg,$(mac_pkgs),$(call uninstall,$(pkg)))
