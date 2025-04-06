{ ... }: {
  imports = [ ./features/git.nix ./features/bash.nix ];

  git.enable = true;
  shell.enable = true;
}
