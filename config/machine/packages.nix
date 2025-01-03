{ pkgs, inputs, ... }:
{

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    hyprpanel
    hyprcursor
    inputs.zen-browser.packages."${system}".default
    wl-clipboard
    playerctl
    git
    wget
    curl
    clang
    jq
    pavucontrol
    greetd.tuigreet
    feh
    brightnessctl
    nix-prefetch-git
    cloudflare-warp
    prettierd
    pulseaudio
    gh
    lm_sensors
    nodejs
    neovim
    ranger
  ];
}
