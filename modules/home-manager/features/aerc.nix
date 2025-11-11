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
        "<C-n>" = ":next-tab <Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<C-t>" = ":term<Enter>";
        "?" = ":help keys<Enter>";
        # keep-sorted end
      };
      messages = {
        # keep-sorted start
        "!" = ":term<space>";
        "$" = ":term<space>";
        "/" = ":search<space>-a<space>";
        "<C-b>" = ":prev 100%<Enter>";
        "<C-d>" = ":next 50%<Enter>";
        "<C-f>" = ":next 100%<Enter>";
        "<C-u>" = ":prev 50%<Enter>";
        "<Down>" = ":next<Enter>";
        "<Enter>" = ":view<Enter>";
        "<Esc>" = ":clear<Enter>";
        "<PgDn>" = ":next 100%<Enter>";
        "<PgUp>" = ":prev 100%<Enter>";
        "<Up>" = ":prev<Enter>";
        "\\" = ":filter <space>";
        "|" = ":pipe<space>";
        A = ":archive flat<Enter>";
        C = ":compose<Enter>";
        D = ":move Trash<Enter>";
        G = ":select -1<Enter>";
        H = ":collapse-folder<Enter>";
        I = ":read<Enter>";
        J = ":next-folder <Enter>";
        K = ":prev-folder<Enter>";
        L = ":expand-folder<Enter>";
        N = ":prev-result<Enter>";
        Rq = ":reply -q<Enter>";
        Rr = ":reply<Enter>";
        T = ":toggle-threads<Enter>";
        U = ":unread<Enter>";
        V = ":mark -v<Enter>";
        c = ":cf<space>";
        d = ":prompt 'Really delete this message?' 'delete-message'<Enter>";
        g = ":select 0 <Enter>";
        j = ":next <Enter>";
        k = ":prev <Enter>";
        n = ":next-result<Enter>";
        q = ":quit<Enter>";
        rq = ":reply -aq<Enter>";
        rr = ":reply -a<Enter>";
        v = ":mark -t<Enter>";
        # keep-sorted end
      };
      "messages:folder=Drafts" = {
        "<Enter>" = ":recall<Enter>";
      };
      view = {
        # keep-sorted start
        "/" = ":toggle-key-passthrough <Enter> /";
        "<C-j>" = ":next-part<Enter>";
        "<C-k>" = ":prev-part<Enter>";
        "<C-l>" = ":open-link <space>";
        "|" = ":pipe<space>";
        A = ":archive flat<Enter>";
        D = ":move Trash<Enter>";
        H = ":toggle-headers<Enter>";
        J = ":next <Enter>";
        K = ":prev<Enter>";
        O = ":open<Enter>";
        R = ":read<Enter>";
        Rq = ":reply -q<Enter>";
        Rr = ":reply<Enter>";
        S = ":save<space>";
        U = ":unread<Enter>";
        f = ":forward <Enter>";
        q = ":close<Enter>";
        rq = ":reply -aq<Enter>";
        rr = ":reply -a<Enter>";
        # keep-sorted end
      };
      "view::passthrough" = {
        # keep-sorted start
        "$ex" = "<C-x>";
        "$noinherit" = "true";
        "<Esc>" = ":toggle-key-passthrough<Enter>";
        # keep-sorted end
      };
      compose = {
        # keep-sorted start
        "$ex" = "<C-x>";
        "$noinherit" = "true";
        "<A-n>" = ":switch-account -n<Enter>";
        "<A-p>" = ":switch-account -p<Enter>";
        "<C-j>" = ":next-field<Enter>";
        "<C-k>" = ":prev-field<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        "<tab>" = ":next-field<Enter>";
        # keep-sorted end
      };
      "compose::editor" = {
        # keep-sorted start
        "$ex" = "<C-x>";
        "$noinherit" = "true";
        "<C-j>" = ":next-field<Enter>";
        "<C-k>" = ":prev-field<Enter>";
        "<C-n>" = ":next-tab<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
        # keep-sorted end
      };
      "compose::review" = {
        # keep-sorted start
        a = ":attach<space>";
        d = ":detach<space>";
        e = ":edit<Enter>";
        n = ":abort<Enter>";
        p = ":postpone<Enter>";
        q = ":choose -o d discard abort -o p postpone postpone<Enter>";
        y = ":send <Enter>";
        # keep-sorted end
      };
      terminal = {
        # keep-sorted start
        "$ex" = "<C-x>";
        "$noinherit" = "true";
        "<C-n>" = ":next-tab<Enter>";
        "<C-p>" = ":prev-tab<Enter>";
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
