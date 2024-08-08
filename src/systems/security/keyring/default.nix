{pkgs, ...}:{
	environment.systemPackages = with pkgs;[
		gnome.gnome-keyring
		libgnome-keyring
		seahorse
	];
	services.gnome.gnome-keyring.enable = true;
}