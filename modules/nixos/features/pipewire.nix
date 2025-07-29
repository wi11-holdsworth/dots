{ config, lib, ... }:
let
  feature = "pipewire";
in
{
  config = lib.mkIf config.${feature}.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      alsa.enable = true;
      alsa.support32Bit = true;
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
