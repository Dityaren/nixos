{ config
, inputs
, pkgs
, ...
}:

{
  imports = [
    ./spicetify
    ./shell
    ./hyprland
    ./nixvim
  ];

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.username = "river";
  home.homeDirectory = "/home/river";

  home.packages = with pkgs; [
    neofetch
    nnn
    unzip
    wget
    lazygit
    ripgrep
    nurl
    nixpkgs-fmt
    tree
    fd
    ripgrep
    eza
    fzf
    nix-output-monitor
    vesktop
  ];

  programs.git = {
    enable = true;
    userName = "Dityaren";
    userEmail = "DitoAdityaSembiringKembaren1@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
