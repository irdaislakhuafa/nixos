# Overview

This is my NixOS configuration files.

## Installation
My configuration use nix flakes, so you just need to clone this repository without need to add new nix-channel or something else.

```sh
$ git clone https://github.com/irdaislakhuafa/nixos.git 
$ cd ./nixos
```

## Usages
After you clone this repository and entering this repository with `cd ./nixos` make sure you have `gnumake` package installed.
This configuration is includes `home-manager` configurations and `nixos` configurations.
- `home-manager`: home manager configuration is on `./home-manager` directory.
- `nixos`: nixos configration in on `src` directory.

For usage or how to apply this configuration you can use command below.
- `home-manager`

  ```sh
  $ make flake-home-switch
  ```

- `nixos`

  if you use `doas` instead of `sudo`.
  
  ```sh
  $ doas make flake-build-switch
  ```

  if you use `sudo` instead of `doas`.
  
  ```sh
  $ sudo make flake-build-switch
  ```

  if you got error like `"Current user is not owner of this repository"`, you need to add this repository as safe directory with commands below.
  
  ```sh
  $ doas git config --global --add --safe.directory $(pwd)
  ```

  `pwd` will print current working directory, if you not on this repository directory you can change `$(pwd)` with path to this reposiroty directory like `/home/$USERNAME/nixos`.

  if all problem is gone, then try to run command `doas make flake-build-swith` again or replace `doas` with `sudo` if you use `sudo`. 
