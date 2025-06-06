{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "link2c";
  dependencies = with config; [
    amd-desktop
    core
  ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="2e1a", ATTR{idProduct}=="4c03", TEST=="power/control", ATTR{power/control}="on"
    '';
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
