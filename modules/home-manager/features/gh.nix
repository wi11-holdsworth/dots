{
  config,
  lib,
  ...
}:
let
  feature = "gh";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        editor = "nvim";
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
