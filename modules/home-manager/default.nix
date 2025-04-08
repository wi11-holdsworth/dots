{ lib, ... }: {
  imports = [
    # TODO dependence!
    # TODO autogenerate this
    ./features/git.nix # depends on nvim, delta, system
    ./features/bash.nix # depends on eza, nvim, nh, system
  ];

  git.enable = lib.mkDefault true;
  bash.enable = lib.mkDefault true;
}
