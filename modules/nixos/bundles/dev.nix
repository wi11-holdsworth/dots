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
    environment.systemPackages = (
      with pkgs;
      (
        [
          # keep-sorted start
          devenv
          just
          mask
          vscode
          bacon
          cargo-info
          rusty-man
          # keep-sorted end
        ]
        ++ (with jetbrains; [
          rider
          webstorm
        ])
      )
    );
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
