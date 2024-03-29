NIXOS_CFG_PATH := /etc/nixos

install:
	@ #if [ -d ${NIXOS_CFG_PATH} ]; then mv -v ${NIXOS_CFG_PATH} ${NIXOS_CFG_PATH}.backup; fi
	@ #ln -sfv $(pwd) ${NIXOS_CFG_PATH}

use:
	@ #if [ -d ${NIXOS_CFG_PATH} ]; then unlink ${NIXOS_CFG_PATH}; fi
	@ #ln -sfv $(pwd) ${NIXOS_CFG_PATH}

home-add-channel:
	@ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
	@ nix-channel --update

use-switch:
	@ make use && nixos-rebuild switch
