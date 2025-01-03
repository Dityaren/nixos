{ pkgs, ... }:
{

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.river = {
    isNormalUser = true;
    description = "river";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };
}
