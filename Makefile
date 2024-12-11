ROOT_DIR := /
NIXOS_CFG_PATH := etc/nixos
PRIVILEGED_CMD := $(command -v doas || command -v sudo)
NIXOS_CHANNEL := https://channels.nixos.org/nixos-unstable
HOME_MANAGER_CHANNEL := https://github.com/rycee/home-manager/archive/master.tar.gz

install:
	@ [ -d ${ROOT_DIR}${NIXOS_CFG_PATH} ] && mv -v ${ROOT_DIR}${NIXOS_CFG_PATH} ${ROOT_DIR}${NIXOS_CFG_PATH}.backup && ln -sfv $(pwd) ${ROOT_DIR}${NIXOS_CFG_PATH} && cp -rv ${ROOT_DIR}${NIXOS_CFG_PATH}.backup/hardware-configuration.nix ${ROOT_DIR}${NIXOS_CFG_PATH}/
	@ ! [ -d ${ROOT_DIR}${NIXOS_CFG_PATH} ] && echo "Please generate hardware-configuration.nix first"

home-add-channel:
	@ [ "$(nix-channel --list | grep home-managers)" = "" ] && nix-channel --add ${HOME_MANAGER_CHANNEL} home-manager && nix-channel --update

sys-switch:
	@ ${PRIVILEGED_CMD} nixos-rebuild switch --fast --log-format bar

home-switch:
	@ home-manager switch

switch:
	@ ${PRIVILEGED_CMD} nixos-rebuild switch --log-format bar --fast && home-manager switch

use-channel-unstable:
	@ nix-channel --add ${NIXOS_CHANNEL} nixos && nix-channel --update
