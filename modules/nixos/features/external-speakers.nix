{
  config,
  lib,
  ...
}:
let
  feature = "external-speakers";
in
{
  config = lib.mkIf config.${feature}.enable {
    boot.extraModprobeConfig = ''
      options snd_hda_intel power_save=0
    '';
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
