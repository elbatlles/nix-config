{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "angel";
  home.homeDirectory = "/home/angel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/angel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs = {
    git = {
      enable = true;
      userName = "elbatlles";
      userEmail = "angelbatlles@gmail.com";
    };
    zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
        statusbar-basename = true;
        window-title-home-tilde = true;
      };
    };
    zellij ={
enable = false;
  enableZshIntegration = true;
  enableBashIntegration = true;
  
    };
    wezterm ={
        enable = false;
  enableZshIntegration = true;
  enableBashIntegration = true;
  
   extraConfig = ''
     -- Pull in the wezterm API

 -- This table will hold the configuration.
-- The config_builder provides clearer error
-- messages.
local config = wezterm.config_builder()

local settings = {
    enable_wayland = true,
    font = wezterm.font("FiraMono Nerd Font Mono"),
    font_rules = {
        {
            italic = true,
            font = wezterm.font("FiraMono Nerd Font Mono", { italic = false }),
        },
    },
    font_size = 11.0,
    enable_tab_bar = true,
    window_background_opacity = 0.9,
    window_close_confirmation = "NeverPrompt",
    skip_close_confirmation_for_processes_named = {
        "bash",
        "fish",
        "chezmoi",
    },
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    show_update_window = false,
    check_for_updates = false,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    keys = {
        { key = "t", mods = "ALT", action = wezterm.action({ SpawnTab = "DefaultDomain" }) },
        { key = "w", mods = "ALT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
        { key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
        { key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
        { key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
        { key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
        { key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
        { key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
        { key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
        { key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
        { key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
    },
    color_scheme = "Gruvbox dark, soft (base16)",

}

-- Copy the settings from the settings table to the config table
for key, value in pairs(settings) do
    config[key] = value
end

return config
    '';
  };
       
  
  };
  #   home.file.".config/swappy/config".text = ''
  #     [Default]
  #     save_dir=/data/$USER/Imágenes/Screenshots
  #     save_filename_format=sw appy-%Y%m%d-%H%M%S.png
  # show_pannel=false
  # line_size=5
  # text-size=20
  # paint_mode=brush
  # early_exit=false
  # fill_shape=false
  #   '';

}
