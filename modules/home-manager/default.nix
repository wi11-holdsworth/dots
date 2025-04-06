{ lib, ... }: {
  imports = [
    # TODO: dependence!
    ./features/git.nix # depends on nvim, delta, system
    ./features/bash.nix # depends on eza, nvim, nh, system
  ];

  git.enable = lib.mkDefault true;
  bash.enable = lib.mkDefault true;
}
