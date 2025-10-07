{
  config,
  lib,
  ...
}:
let
  feature = "espanso";
in
{
  config = lib.mkIf config.${feature}.enable {
    services.espanso = {
      enable = true;
      matches.base.matches = [
        # keep-sorted start block=yes
        {
          trigger = ":tdtdy";
          replace = "ls -x -s priority 't:<=today'";
        }
        {
          trigger = ":tdtmrw";
          replace = "ls -x -s priority 't:<=tomorrow'";
        }
        # keep-sorted end
      ];
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
