{ lib, ... }: {
  imports = [ ./features/git.nix ./features/bash.nix ];

  git.enable = lib.mkDefault true;
  bash.enable = lib.mkDefault true;
}
