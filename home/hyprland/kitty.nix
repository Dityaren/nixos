{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
    };
    extraConfig = ''
      background_opacity 0.9
    '';
  };
}
