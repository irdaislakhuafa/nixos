NIXOS_CFG_PATH := /etc/nixos/

use:
	@ cp -rv * ${NIXOS_CFG_PATH}

use-switch:
	@ make use && nixos-rebuild switch
