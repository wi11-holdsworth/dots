{ lib, ... }: {
  imports = [ ./features/git.nix ./features/bash.nix ];

  git.enable = lib.mkDefault true;
  shell.enable = lib.mkDefault true;
}
