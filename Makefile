USERNAME := i
HOSTNAME := developer
flake-build-switch:
	@ nixos-rebuild switch --fast --log-format bar --flake .#${HOSTNAME}

flake-home-switch:
	@ home-manager switch --flake .#${USERNAME}
