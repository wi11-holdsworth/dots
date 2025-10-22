{
  accounts.email.accounts.personal.aerc.enable = true;
  programs.aerc = {
    enable = true;
    extraAccounts.personal = {
      default = "INBOX";
      folders-sort = "INBOX, Starred, Drafts, Sent, Trash, Archive, Spam";
    };
    extraConfig = {
      general.unsafe-accounts-conf = true;
      filters = {
        "text/plain" = "colorize";
        "text/calendar" = "calendar | colorize";
        "text/html" = "html | colorize";
      };
      ui = {
        styleset-name = "catppuccin-mocha";
        sort = "-r date";
      };
    };
    extraBinds = {
      global = {
        # keep-sorted start
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab <Enter>";
        "<C-t>" = ":term<Enter>";
        "?" = ":help keys<Enter>";
        # keep-sorted end
      };
      messages = {
        # keep-sorted start
        q = ":quit<Enter>";
        j = ":next <Enter>";
        "<Down>" = ":next<Enter>";
        "<C-d>" = ":next 50%<Enter>";
        "<C-f>" = ":next 100%<Enter>";
        "<PgDn>" = ":next 100%<Enter>";
        k = ":prev <Enter>";
        "<Up>" = ":prev<Enter>";
        "<C-u>" = ":prev 50%<Enter>";
        "<C-b>" = ":prev 100%<Enter>";
        "<PgUp>" = ":prev 100%<Enter>";
        g = ":select 0 <Enter>";
        G = ":select -1<Enter>";
        J = ":next-folder <Enter>";
        K = ":prev-folder<Enter>";
        H = ":collapse-folder<Enter>";
        L = ":expand-folder<Enter>";
        v = ":mark -t<Enter>";
        V = ":mark -v<Enter>";
        T = ":toggle-threads<Enter>";
        "<Enter>" = ":view<Enter>";
        d = ":prompt 'Really delete this message?' 'delete-message'<Enter>";
        D = ":move Trash<Enter>";
        A = ":archive flat<Enter>";
        U = ":unread<Enter>";
        R = ":read<Enter>";
        C = ":compose<Enter>";
        rr = ":reply -a<Enter>";
        rq = ":reply -aq<Enter>";
        Rr = ":reply<Enter>";
        Rq = ":reply -q<Enter>";
        c = ":cf<space>";
        "$" = ":term<space>";
        "!" = ":term<space>";
        "|" = ":pipe<space>";
        "/" = ":search<space>-a<space>";
        "\\" = ":filter <space>";
        n = ":next-result<Enter>";
        N = ":prev-result<Enter>";
        "<Esc>" = ":clear<Enter>";
        # keep-sorted start
      };
      "messages:folder=Drafts" = {
        "<Enter>" = ":recall<Enter>";
      };
      view = {
        # keep-sorted start
        "/" = ":toggle-key-passthrough <Enter> /";
        q = ":close<Enter>";
        O = ":open<Enter>";
        S = ":save<space>";
        "|" = ":pipe<space>";
        D = ":move Trash<Enter>";
        A = ":archive flat<Enter>";
        U = ":unread<Enter>";
        R = ":read<Enter>";
        "<C-l>" = ":open-link <space>";
        f = ":forward <Enter>";
        rr = ":reply -a<Enter>";
        rq = ":reply -aq<Enter>";
        Rr = ":reply<Enter>";
        Rq = ":reply -q<Enter>";
        H = ":toggle-headers<Enter>";
        "<C-k>" = ":prev-part<Enter>";
        "<C-j>" = ":next-part<Enter>";
        J = ":next <Enter>";
        K = ":prev<Enter>";
        # keep-sorted end
      };
      "view::passthrough" = {
        # keep-sorted start
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<Esc>" = ":toggle-key-passthrough<Enter>";
        # keep-sorted end
      };
      compose = {
        # keep-sorted start
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<C-k>" = ":prev-field<Enter>";
        "<C-j>" = ":next-field<Enter>";
        "<A-p>" = ":switch-account -p<Enter>";
        "<A-n>" = ":switch-account -n<Enter>";
        "<tab>" = ":next-field<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        # keep-sorted end
      };
      "compose::editor" = {
        # keep-sorted start
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<C-k>" = ":prev-field<Enter>";
        "<C-j>" = ":next-field<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        # keep-sorted end
      };
      "compose::review" = {
        # keep-sorted start
        y = ":send <Enter>";
        n = ":abort<Enter>";
        p = ":postpone<Enter>";
        q = ":choose -o d discard abort -o p postpone postpone<Enter>";
        e = ":edit<Enter>";
        a = ":attach<space>";
        d = ":detach<space>";
        # keep-sorted end
      };
      terminal = {
        # keep-sorted start
        "$noinherit" = "true";
        "$ex" = "<C-x>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        # keep-sorted end
      };
    };
    stylesets.catppuccin-mocha = ''
      "*.default" = true
      "*.normal" = true
      "default.fg" = "#cdd6f4"
      "error.fg" = "#f38ba8"
      "warning.fg" = "#fab387"
      "success.fg" = "#a6e3a1"
      "tab.fg" = "#6c7086"
      "tab.bg" = "#181825"
      "tab.selected.fg" = "#cdd6f4"
      "tab.selected.bg" = "#1e1e2e"
      "tab.selected.bold" = true
      "border.fg" = "#11111b"
      "border.bold" = true
      "msglist_unread.bold" = true
      "msglist_flagged.fg" = "#f9e2af"
      "msglist_flagged.bold" = true
      "msglist_result.fg" = "#89b4fa"
      "msglist_result.bold" = true
      "msglist_*.selected.bold" = true
      "msglist_*.selected.bg" = "#313244"
      "dirlist_*.selected.bold" = true
      "dirlist_*.selected.bg" = "#313244"
      "statusline_default.fg" = "#9399b2"
      "statusline_default.bg" = "#313244"
      "statusline_error.bold" = true
      "statusline_success.bold" = true
      "completion_default.selected.bg" = "#313244"
    '';
  };
}
