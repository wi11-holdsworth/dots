{
  config,
  lib,
  userName,
  ...
}:
let
  feature = "nh";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.nh = {
      enable = true;
      # clean.enable = true;
      flake = "/home/${userName}/.dots";
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
