{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "dev";
in
{
  config = lib.mkIf config.${feature}.enable {
    environment.systemPackages = with pkgs; [
      # general
      devenv
      just
      mask
      vscode

      # rust
      bacon
      cargo-info
      rusty-man
    ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
