{ ... }:
{
  imports = [
    ./tmux.nix
  ];

  programs.zsh.enable = true;
  programs.zsh.initExtraFirst = "
    export EDITOR=nvim
  ";
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.shellAliases = {
    ll = "exa -l --icons=always";
    ls = "exa -G --icons=always";
    la = "exa -a --icons=always";
    l = "exa -A -l --icons=always";
    vim = "nvim";
    vi = "nvim";
    prettier = "prettierd";
    ".." = "cd ..";
    spotify = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

  programs.oh-my-posh.enable = true;
  programs.oh-my-posh.enableZshIntegration = true;
  programs.oh-my-posh.useTheme = "1_shell";

}
