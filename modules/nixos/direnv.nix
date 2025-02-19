{
  programs.direnv.enable = true;
  programs.bash.shellInit = ''
    dv() {
      nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$1"
    }
  '';
}
