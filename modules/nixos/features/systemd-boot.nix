{ config, lib, ... }:
let
  feature = "systemd-boot";
in
{
  config = lib.mkIf config.${feature}.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
