{
  config,
  lib,
  ...
}:
let
  feature = "link2c";
in
{
  config = lib.mkIf config.${feature}.enable {
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="2e1a", ATTR{idProduct}=="4c03", TEST=="power/control", ATTR{power/control}="on"
    '';
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
