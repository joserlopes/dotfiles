{...}: {
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # custom settings
    settings = {
      format = ''
        $os $username @ $shell $sudo
        [┣❯](bold red) $directory
        [╰──❯ ](bold green)
      '';
      username = {
        disabled = false;
        show_always = true;
        format = "[$user]($style)";
      };
      hostname = {
        disabled = true;
        ssh_only = false;
        style = "bold white";
        format = "[$hostname]($style)";
      };
      sudo = {
        disabled = false;
        symbol = " ";
        style = "bold #FF0000";
        format = "[as $symbol]($style)";
        allow_windows = false;
      };
      shell = {
        disabled = false;
        style = "bold green";
        bash_indicator = "";
        zsh_indicator = "zsh";
        fish_indicator = "";
        powershell_indicator = "_";
        cmd_indicator = "";
        ion_indicator = "ino _";
        elvish_indicator = "elvish _";
        tcsh_indicator = "tcsh _";
        xonsh_indicator = "xonsh _";
        nu_indicator = "nu _";
        unknown_indicator = "";
      };
      os = {
        format = "[$symbol](bold blue)";
        disabled = false;
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = "";
          # EndeavourOS = "";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };
      };
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
}
