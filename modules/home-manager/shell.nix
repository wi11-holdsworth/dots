{
  editor,
  dots,
  ...

}: {
  programs = {
    # initialise bash with some aliases
    bash = {
      enable = true;

      shellAliases = {
        ls = "eza --group-directories-first --icons";
        la = "ls -a";
        ll = "la -l";
        lt = "la -T";

        vi = "${editor}";
        vim = "${editor}";

        dots = "cd ${dots} && clear && ls -T && echo";
        nos = "nh os switch ${dots}";
      };
    };

    # initialise starship with some pretty colours and preferential defaults
    starship = {
      enable = true;

      settings = {
        add_newline = false;
        
        cmd_duration.disabled = true;
        
        line_break.disabled = true;

        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[➜](bold red) ";
        };
      };
    }; 
  };
}
