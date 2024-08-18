NIXOS_CFG_PATH := /etc/nixos

install:
	@ if [ -d ${NIXOS_CFG_PATH} ]; then mv -v ${NIXOS_CFG_PATH} ${NIXOS_CFG_PATH}.backup; fi
	@ ln -sfv $(pwd) ${NIXOS_CFG_PATH}

home-add-channel:
	@ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	@ nix-channel --update

switch:
	@ nixos-rebuild switch

use-channel-unstable:
	@ nix-channel --add https://channels.nixos.org/nixos-unstable nixos
	@ nix-channel --update
