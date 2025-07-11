{ config, lib, ... }:
let
  feature = "nix-settings";
in
{
  config = lib.mkIf config.${feature}.enable {
    nix = {
      optimise.automatic = true;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "will"
          "srv"
        ];
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
