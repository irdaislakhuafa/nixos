# Overview

This repository contains my personal NixOS and Home Manager configurations. It uses Nix Flakes with a pinned `nixpkgs` commit hash to ensure reproducible builds across updates.

## Architecture

The configuration is modular and makes use of an automated directory importer helper (`importer.nix`) so you never have to manually register every single configuration file in an explicit imports list.

- **`flake.nix`**: The root flake entry point. Defines inputs (`nixpkgs`, `home-manager`, `scls`, `iwmenu`, `flake-utils`) and outputs:
  - `nixosConfigurations.developer`: System configuration targeting host `developer`.
  - `homeConfigurations.i`: Home Manager configuration targeting user `i`.
- **`importer.nix`**: A helper script that automatically reads all subdirectories in a given folder and imports their `default.nix` files.
- **`src/`**: NixOS system-wide configurations. Everything placed here is automatically included via `src/default.nix`.
  - **`src/systems/`**: Core OS subsystems (boot, networking, hardware, graphics, audio, users, security, etc.).
  - **`src/apps/`**: System-level applications and services (virtualization, builders, etc.).
- **`home-manager/`**: User environment configurations.
  - **`home-manager/home.nix`**: Entry point for Home Manager, which automatically loads all modules inside `home-manager/src/configs/`.
  - **`home-manager/src/configs/`**: User tools and desktop applications (Hyprland, Waybar, Helix, Neovim, Fish, Git, etc.).

## Adding a New Nix Configuration

Because the repository uses automatic directory scanning (`importer.nix`), adding a new configuration module is straightforward.

### Important: Git Tracking Requirement

Nix flakes only evaluate files tracked by Git. When you create new configuration files or directories, you must stage them with git before rebuilding:

```sh
$ git add src/systems/my-service/
# or
$ git add .
```

### 1. Adding a System-Wide NixOS Module

1. Create a new directory under `src/systems/` or `src/apps/`, for example: `src/systems/my-service/`.
2. Inside that directory, create a `default.nix` file defining your NixOS module options:
   ```nix
   { config, pkgs, ... }:
   {
     # Your NixOS configuration options here
   }
   ```
3. The configuration will be discovered and loaded automatically on the next system rebuild.

### 2. Adding a Home Manager Module

1. Create a new directory under `home-manager/src/configs/`, for example: `home-manager/src/configs/my-tool/`.
2. Inside that directory, create a `default.nix` file defining your Home Manager options:
   ```nix
   { config, pkgs, ... }:
   {
     # Your Home Manager configuration options here
   }
   ```
3. The module will be discovered and loaded automatically on the next home-manager switch.

## Installation

Clone this repository:

```sh
$ git clone https://github.com/irdaislakhuafa/nixos.git
$ cd ./nixos
```

## Usage

Make sure you have `gnumake` installed. You can apply system or user configurations using the provided Makefile commands.

### 1. Apply NixOS System Configuration

If you use `doas`:

```sh
$ doas make flake-build-switch
```

If you use `sudo`:

```sh
$ sudo make flake-build-switch
```

### 2. Apply Home Manager Configuration

```sh
$ make flake-home-switch
```

### Git Safe Directory Notice

If you encounter an error stating `"Current user is not owner of this repository"`, you must add the repository as a safe directory in git:

```sh
$ doas git config --global --add safe.directory $(pwd)
```

Replace `$(pwd)` with the absolute path to your repository directory (such as `/home/USERNAME/nixos`) if you are running the command from outside the repository folder. After adding it to safe directories, rerun your build command.
