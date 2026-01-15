{
  pkgs,
  ...
}:
{
  home.shell.enableFishIntegration = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      # INFO: Using this to get shell completion for programs added to the path through nix+direnv.
      # Issue to upstream into direnv:Add commentMore actions
      # https://github.com/direnv/direnv/issues/443
      {
        name = "completion-sync";
        src = pkgs.fetchFromGitHub {
          owner = "iynaix";
          repo = "fish-completion-sync";
          rev = "4f058ad2986727a5f510e757bc82cbbfca4596f0";
          sha256 = "sha256-kHpdCQdYcpvi9EFM/uZXv93mZqlk1zCi2DRhWaDyK5g=";
        };
      }
    ];
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
}
