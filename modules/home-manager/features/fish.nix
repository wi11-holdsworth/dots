{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "fish";
in
{
  config = lib.mkIf config.${feature}.enable {
    home.shell.enableFishIntegration = true;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellAliases = {
        # keep-sorted start
        cat = "bat";
        # cd = "j";
        cut = "choose";
        df = "duf";
        du = "dua";
        # find = "fd";
        g = "lazygit";
        l = "eza";
        la = "eza -a";
        ls = "eza";
        ns = "nh os switch";
        # curl = "xh";
        ping = "gping";
        ps = "procs";
        # sed = "sd";
        # grep = "rga";
        top = "btm";
        unzip = "ripunzip";
        vi = "nvim";
        vim = "nvim";
        # keep-sorted end
      };
    };

    # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
    programs.bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
