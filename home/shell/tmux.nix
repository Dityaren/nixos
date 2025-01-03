{ pkgs, ... }:
let
  #https://github.com/janoamaral/tokyo-night-tmux
  tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night";
    rtpFilePath = "tokyo-night.tmux";
    version = "v1.5.5";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "b45b742eb3fdc01983c21b1763594b549124d065";
      sha256 = "sha256-k4CbfWdyk7m/T97ytxLOEMUKrkU5iJSIu3lvyT1B1jU=";
    };
  };
  tmux-sensible = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-sensible";
    rtpFilePath = "sensible.tmux";
    version = "v2022-08-14T22";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-sensible";
      rev = "25cb91f42d020f675bb0a2ce3fbd3a5d96119efa";
      sha256 = "sha256-sw9g1Yzmv2fdZFLJSGhx1tatQ+TtjDYNZI5uny0+5Hg=";
    };
  };
in
{

  home.packages = with pkgs; [
    sesh
    zoxide
  ];

  programs.tmux = {
    enable = true;
    shortcut = "a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      {
        plugin = tokyo-night;
        extraConfig = ''
          set -g @tokyo-night-tmux_show_music 1
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmux-sensible;
        extraConfig = ''
          # Address vim mode switching delay (http://superuser.com/a/252717/65504)
          set -s escape-time 0

          # Increase scrollback buffer size from 2000 to 50000 lines
          set -g history-limit 50000

          # Increase tmux messages display duration from 750ms to 4s
          set -g display-time 4000

          # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
          set -g status-interval 0

          # Upgrade $TERM
          set -g default-terminal "screen-256color"

          # Emacs key bindings in tmux command prompt (prefix + :) are better than
          # vi keys, even for vim users
          set -g status-keys emacs

          # Focus events enabled for terminals that support them
          set -g focus-events on

          # Super useful when using "grouped sessions" and multi-monitor setup
          setw -g aggressive-resize on
        '';
      }
      tmuxPlugins.better-mouse-mode
    ];
    extraConfig = ''
        bind-key "T" run-shell "sesh connect \"$(
        sesh list --icons | fzf-tmux -p 55%,60% \
          --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
      )\""
    '';
  };
}
