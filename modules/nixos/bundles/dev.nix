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
      # keep-sorted start
      bacon
      cargo-info
      devenv
      just
      mask
      rusty-man
      vscode
      # keep-sorted end
    ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
