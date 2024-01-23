NIXOS_CFG_PATH := /etc/nixos

install:
	@ #if [ -d ${NIXOS_CFG_PATH} ]; then mv -v ${NIXOS_CFG_PATH} ${NIXOS_CFG_PATH}.backup; fi
	@ #ln -sfv . ${NIXOS_CFG_PATH}
use:
	@ #if [ -d ${NIXOS_CFG_PATH} ]; then unlink ${NIXOS_CFG_PATH}; fi
	@ #ln -sfv . ${NIXOS_CFG_PATH}
use-switch:
	@ make use && nixos-rebuild switch
