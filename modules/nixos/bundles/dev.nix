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
          bacon
          cargo-info
          devenv
          just
          mask
          rusty-man
          zed-editor
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
