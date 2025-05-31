{ config, pkgs, lib, inputs, ... }:      # whatever to import from flakes

 #-----------------------------------------------------------------------------  create home --------------------------------------
 { 
  home.username = "wheatflake";
  home.homeDirectory = "/home/wheatflake";
  home.stateVersion = "25.11";

 #--------------------------------------------------------------- Packages installed as options ------------------------------------------
 
 home.file.".config/hypr/hyprpaper.conf".text = ''
 preload = /home/wheatflake/Pictures/hyprland-wallpapers/Fantasy-Landscape-NIght.png
 wallpaper = eDP-1,/home/wheatflake/Pictures/hyprland-wallpapers/Fantasy-Landscape-NIght.png
 ipc = 0n
'';
 #--------------------------------------------- Packages to install for the user --------------------------------

  home.packages = with pkgs; [

 #-------------------------------------- core utilities to run hyprland (optional in nature) -------------------------------------------
 
    kitty                               # terminal emulator
    meson                               # build system, made in python
    nautilus                            # file manager from gnome
    cava                                # visual audio analyser
    vim                                 # editor
    distrobox                           # test distributions using native kernels
    librewolf                           # web browser
    vlc                                 # multimedia player
    aria2                               # external dowload manager
    irssi                               # terminal irc client
    tgpt                                # gpt in terminal
    android-tools                       # for android development
    eog                                 # eye of gnome
    superfile                           # terminal file manager
    chromium                            # web browser (for compatibility)
    evince                              # document reader
    blanket                             # soothing sounds
    youtube-music                       # electron app
    bottles                             # wine manager
    vscodium                              # integrated desktop environment
    spice                               # display server for virtual machines
    virtiofsd                           # --------------------
    
  
 #------------------------------------- Hyprland ecosystem tools -----------------------------------------------------------------

    hyprpaper                           # wallpaper utility
    hyprpicker                          # color picker from your screen
    hypridle                            # idle management  daemon
    hyprlock                            # screen locker
    xdg-desktop-portal-hyprland         # lets other applications communicate with the compositor through D-Bus
    hyprsunset                          # blue light filter, undetected in screenshots
    hyprpolkitagent                     # polkit authentication daemon, allows GUI applications for elevated permissions
    hyprsysteminfo                      # GUI application that displays system information
    hyprland-qt-support                 # provides QML style for hypr*qt6 apps
    hyprcursor                          # new cursor theme format
    hyprutils                           # library providing shared implementations of commonly used types across the hypr* ecosystem
    hyprlang                            # library provides parsing of the hypr configuration language
    hyprwayland-scanner                 # hw-s,is a utility to generate sources and headers for wayalnd protocol specifications (generates c++ implementations)
    aquamarine                          # lightweight linux rendering backend library
    hyprgraphics                        # library providing shared implementations of utilities related to graphics and resources, like loading images or color calculations
    hyprland-qtutils                    # small bunch of utility applications that hyprland might invoke (stuffs like dialogs and popups)
    
 #----------------------------------- Hyprland useful utilities -----------------------------------------------------------------

   swaynotificationcenter               # must have notification daemon for smooth hyprland experience (includes pipewire, XDG desktop portal, Authentication agent, Qt wayland support)
   waybar                               # wayland native panel
   eww                          # compositor independent to create widgets (alternative:fabric) , I prefer over waybar
   wofi                                 # launcher
   clipse                               # clipboard manager, stores both text and images, can display in a box (alternative:cliphist)
   wl-clip-persist                      # solves the problem of copied data getting deleted from clipboard upon closing of applications
   wl-clipboard                         # required for clipboards in wayland , cli utility for wayland
   udiskie                              # mounts mass storage devices automatically
   overskride                           # powerful bluetoothclient in gtk4
#   nm-applet                            # gnome's tray to configure network, needs tray so doesn't work with hyprbar but waybar
   ashell                               # minimal alternative to nm-applet(wayland native), simple independent window popup, doesn't require a tray
   playerctl                            # cli tool to control media players
   wldash                               # a wayland native launcher
   wlogout                              # manages logout options, exists independently of hyprlock
   fira-code                            # font to be used   
   nwg-look                             # GTK settings editor, designed to work properly in wlroots-based Wayland environment
 ];
 #---------------------------------- Hyprland plugins ----------------------------------------------------------------------------
  
  wayland.windowManager.hyprland = {
     enable = true;
     
 #   plugins = [
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hy3                            # i3/sway like layout
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.Hyprbars                       # provides a bar
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprgrass                      # touch gestures
 #       inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo                       # zoomed out workspace
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.Bordersplusplus                # extra window borders
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprspace                      # workspace overview
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hypr-darkwindow                # Invert window colors
 #       inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling                  # scrolling layout for hyprland
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprNStack                     # N-Stack tiling
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-virtual-desktops      # virtual desktops
 #       inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.Hyprwinwrap                    # Any app as wallpaper
 #       inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion            # Easymotion for hyprland
 #        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors           # cursor physics for hyprland
 #     ];
 

 #------------------------------- Application startup options (Dispatchers) ---------------------------------------------------------------------------

 settings = {

  exec-once = [
    
    "systemctl --user enable --now hyprpaper.service"
    "hypridle"
    "systemctl --user start hyprpolkitagent"
    "swaynotificationcenter"
    "waybar"
    "clipse -listen"
    "udiskie"
    "hyprpm reload -n"
    
   ];

 #------------------------------------------ Monitor setup -------------------------------------------------------------------------------------

  monitor = "eDP-1, 1920x1200@60, 0x0, 1";

 #----------------------------------------- wallpaper settings ----------------------------------------------------------------------

 #--------------------------------------- key bindings --------------------------------------------------------------------

  "$mod" = "SUPER";
      bind = [
        "$mod, return, exec, kitty"
        "$mod, C, killactive," 
        "$mod, M, exit,"
        "$mod, TAB, exec, nautilus"
        "$mod, space, togglefloating,"
        "$mod, D, exec, rofi -show drun"
        "$mod, P, pseudo"
        "$mod, B, togglesplit,"
        "$mod, V, exec, kitty --class clipse -e clipse"
        "$mod, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')"  # for zooming
        "$mod, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')"    # for zooming
        "$mod SHIFT, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor 1"                                                                        # for zooming
        "$mod SHIFT, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor 1"                                                                      # for zooming
        "$mod SHIFT, minus, exec, hyprctl -q keyword cursor:zoom_factor 1"                                                                           # for zooming
        "$mod SHIFT, KP_SUBTRACT, exec, hyprctl -q keyword cursor:zoom_factor 1"                                                                     # for zooming
        "$mod SHIFT, 0, exec, hyprctl -q keyword cursor:zoom_factor 1"                                                                               # for zooming

   
  # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

  # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

  # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

  # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

  # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
     ];

  bindm = [
  # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
    ];

  bindel = [
  # Laptop multimedia keys for volume and LCD brightness
         ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
         ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
         ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
         ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
         ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
         ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
     ];

   bindl = [   
  # Requires playerctl
         ", XF86AudioNext, exec, playerctl next"
         ", XF86AudioPause, exec, playerctl play-pause"
         ", XF86AudioPlay, exec, playerctl play-pause"
         ", XF86AudioPrev, exec, playerctl previous"
      ];

  # For further zooming options

  binde = [
        "$mod, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')"
        "$mod, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')"
        "$mod, KP_ADD, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')"
        "$mod, KP_SUBTRACT, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')"
      ];

 #---------------------------------------------------------- Window rules --------------------------------------------------------------------------------------------------

  windowrule = [
          "opacity 1.0 override 0.3 override,title:(.*)(- Youtube)"                     # opacity 1 for anywindow containing "youtube" string
          "float, class:monophony, title:monophony"                                     # monophony app always opens in floating window
          "float, class:(clipse)"
          "size 622 652, class:(clipse)"
          "stayfocused, class:(clipse)"
        ];
 
 #--------------------------------------------------------- Workspace rules -----------------------------------------------------------------------------------------------
 
  workspace = [

            "3, rounding:false, decorate:false"
            "name:coding, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, monitor:DP-1"
            "8,bordersize:8 "
            "name:Hello, monitor:DP-1, default:true"
            "name:gaming, monitor:desc:Chimei Innolux Corporation 0x150C, default:true"
            "5, on-created-empty:[float] firefox"
            "special:scratchpad, on-created-empty:foot"
      
         ];

 #--------------------------------------------------------------- Variables ------------------------------------------------------------------------------------------
  general = {
      border_size = "1";
      no_border_on_floating = false;
      gaps_in = "10, 10, 10, 10";
      gaps_out = "10, 10, 10, 10";
      gaps_workspaces = "0";
      col.inactive_border = "#E94057";
      col.active_border = "#3b8d99";
      col.nogroup_border = "#240b36";
      col.nogroup_border_active = "#93291E";
      "layout" = "dwindle";
      no_focus_fallback = true;
      resize_on_border = true;
      extend_border_grab_area = "5";
      hover_icon_on_border = true;
      allow_tearing = true;
      resize_corner = "0"; 
   
  
     snap = {
        enabled = true;
        window_gap = "5";
        monitor_gap = "10";
        border_overlap = false;
      };
  };

  decoration = {
    rounding = "6";
    rounding_power = "4.0";
    active_opacity = "0.7";
    inactive_opacity = "0.6";
    fullscreen_opacity = "0.97";
    dim_inactive = true;
    dim_strength = "0.3";
    dim_special = "0.2";
    dim_around = "0.3";
    screen_shader = "";
    border_part_of_window = true;
   

    blur = {
       enabled = true;
       size = "8";
       passes = "1";
       ignore_opacity = true;
       new_optimizations = true;
       xray = true;
       noise = "0.0117";
       contrast = "0.5";
       brightness = "0.8172";
       vibrancy = "0.1696";
       vibrancy_darkness = "0.0";
       special = true;
       popups = true;
       popups_ignorealpha = "0.2";
       input_methods = false;
       input_methods_ignorealpha = "0.2";
     };
   

    shadow = {
       enabled = true;
       range = "4";
       render_power = "3";
       sharp = false;
       ignore_window = true;
       color = "0xee1a1a1a";
       color_inactive = "";
       offset = [0 0];
       scale = "1.0";
    };
  };

  animations = {
    enabled = true;
    first_launch_animation = true;
    workspace_wraparound = false;  
  };
 
  input = {
    kb_model = "";
    kb_layout = "us";
    kb_variant = "";
    kb_options = "";
    kb_rules = "";
    kb_file = "";
    numlock_by_default = true;
    resolve_binds_by_sym = false;
    repeat_rate = "25";
    repeat_delay = "600";
    sensitivity = "0.0";
    accel_profile = "";
    force_no_accel = false;
    left_handed = false;
    scroll_points = "";
    scroll_method = "";
    scroll_button = "0";
    scroll_button_lock = "0";
    scroll_factor = "1.0";
    natural_scroll = true;
    follow_mouse = true;
    follow_mouse_threshold = "0.0";
    focus_on_close = "1";
    mouse_refocus = "1";
    float_switch_override_focus = "1";
    special_fallthrough = false;
    off_window_axis_events = "1";
    emulate_discrete_scroll = "1";
  

    touchpad = {
       disable_while_typing = false;
       natural_scroll = true;
       scroll_factor = "1.0";
       middle_button_emulation = false;
       tap_button_map = "";
       clickfinger_behavior = true;
       tap-to-click = true;
       drag_lock = false;
       tap-and-drag = true;
       flip_x = false;
       flip_y = false;
    };

   touchdevice = {
      transform = "-1";
      output = "";
      enabled = true;
    };
  
 #  tablet = {
 #    transform = "-1";
 #    output = "";
 #    region_position = [0 0];
 #    absolute_region_position = false;
 #    region_size = [0 0];
 #    relative_input = false;
 #    left_handed = false;
 #    active_area_size = [0 0];
 #    active_area_position = [0 0];
 #   };
  };

  gestures = {
    workspace_swipe = true;
    workspace_swipe_fingers = "3";
    workspace_swipe_min_fingers = false;
    workspace_swipe_distance = "300";
    workspace_swipe_touch = false;
    workspace_swipe_invert = false;
    workspace_swipe_touch_invert = false;
    workspace_swipe_min_speed_to_force = "30";
    workspace_swipe_cancel_ratio = "0.5";
    workspace_swipe_create_new = true;
    workspace_swipe_direction_lock = true;
    workspace_swipe_forever = false;
    workspace_swipe_use_r = false;
  };

  group = {
   auto_group = true;
   insert_after_current = true;
   focus_removed_window = true;
   drag_into_group = "1";
   merge_groups_on_drag = true;
   merge_groups_on_groupbar = true;
   merge_floated_into_tiled_on_groupbar = true;
   group_on_movetoworkspace = false;
   col.border_active = "0x66ffff00";
   col.border_inactive = "0x66777700";
   col.border_locked_active = "0x66ff5500";
   col.border_locked_inactive = "0x66775500";
    
  groupbar = {
     enabled = true;
     font_family = "";
     font_size = "8";
     font_weight_active = "normal";
     font_weight_inactive = "normal";
     gradients = false;
     height = "14";
     indicator_gap = "0";
     indicator_height = "3";
     stacked = false;
     priority = "3";
     render_titles = true;
     text_offset = "0";
     scrolling = true;
     rounding = "1";
     gradient_rounding = "2";
     round_only_edges = true;
     gradient_round_only_edges = true;
     text_color = "0xffffffff";
     col.active = "0x66ffff00";
     col.inactive = "0x66777700";
     col.locked_active = "0x66ff5500";
     col.locked_inactive = "0x66775500";
     gaps_in = "2";
     gaps_out = "2";
     keep_upper_gap = true;
    };
  };
  
  misc = {
   disable_hyprland_logo = true;
   disable_splash_rendering = false;
   col.splash = "0xffffffff";
   font_family = "iosevka";
   splash_font_family = "";
   force_default_wallpaper = "-1";
   vfr = true;
   vrr = "3";
   mouse_move_enables_dpms = false;
   key_press_enables_dpms = true;
   always_follow_on_dnd = true;
   layers_hog_keyboard_focus = true;
   animate_manual_resizes = true;
   animate_mouse_windowdragging = true;
   disable_autoreload = true;
   enable_swallow = false;
   swallow_regex = "";
   swallow_exception_regex = "";
   focus_on_activate = false;
   mouse_move_focuses_monitor = true;
   render_ahead_of_time = false;
   render_ahead_safezone = "1";
   allow_session_lock_restore = true;
   background_color = "0x111111";
   close_special_on_empty = true;
   new_window_takes_over_fullscreen = "2";
   exit_window_retains_fullscreen = false;
   initial_workspace_tracking = "1";
   middle_click_paste = true;
   render_unfocused_fps = "15";
   disable_xdg_env_checks = false;
   disable_hyprland_qtutils_check = false;
   lockdead_screen_delay = "1000";
   enable_anr_dialog = true;
   anr_missed_pings = "1";
  };
 
  binds = {
   pass_mouse_when_bound = false;
   scroll_event_delay = "300";
   workspace_back_and_forth = false;
   hide_special_on_workspace_change = false;
   allow_workspace_cycles = false;
   workspace_center_on = "0";
   focus_preferred_method = "0";
   gnore_group_lock = false;
   movefocus_cycles_fullscreen = false;
   movefocus_cycles_groupfirst = false;
   disable_keybind_grabbing = false;
   window_direction_monitor_fallback = true;
   allow_pin_fullscreen = false;
   drag_threshold = "0";     
  };
  
  xwayland = {
   enabled = true;
   use_nearest_neighbor = true;
   force_zero_scaling = false;
   create_abstract_socket = false; 
  };
       
  nvidia_anti_flicker = true;
    
  render = {
   explicit_sync = "1";
   explicit_sync_kms = "1";
   direct_scanout = "0";  
   expand_undersized_textures = true;
   xp_mode = false;
   ctm_animation = "2";
   cm_fs_passthrough = "2";
   cm_enabled = true;
   send_content_type = true;
  };

  cursor = {
   sync_gsettings_theme = true;
   no_hardware_cursors = "1";
   no_break_fs_vrr = "2";
   min_refresh_rate = "24";
   hotspot_padding = "1";
   inactive_timeout = "5.0";
   no_warps = false;
   persistent_warps = false;
   warp_on_change_workspace = "1";
   warp_on_toggle_specia = "0";
   default_monitor = "";
   zoom_factor = "1.0";
   zoom_rigid = false;
   enable_hyprcursor = true;
   hide_on_key_press = false;
   hide_on_touch = true;
   use_cpu_buffer = "2";
   warp_back_after_non_mouse_input = false;
  };

  ecosystem = {
   no_update_news = false;
   no_donation_nag = true;
   enforce_permissions = true;
  };

  experimental = {
   xx_color_management_v4 = false;
  };

  debug = {
   overlay = false;
   damage_blink = false;
   disable_logs = true;
   disable_time = true;
   damage_tracking = "2";
   enable_stdout_logs = false;
   manual_crash = "0";
   suppress_errors = true;
   watchdog_timeout = "5";
   disable_scale_checks = false;
   error_limit = "4";
   error_position = "-1";
   colored_stdout_logs = true;
   pass = false;
   full_cm_proto = false;
  };
 };
};      
 #---------------------------------------------------------- Screen teraing ---------------------------------------------------------------------------------
 # used to reduce latency in games

 #--------------------------------------------------------- Dwindle layout ----------------------------------------------------------------------------------
 # Dwindle is a BSPWM-like layout, where every window on a workspace is a member of a binary tree

 # -------------------------------------------------------- Master layout ------------------------------------------------------------------------------
 #----------------------------------------------------------Permissions -----------------------------------------------------------------------------------
  # permission = "/usr/(bin|local/bin)/hyprpm, plugin, allow";

 # --------------------------------------------------------- Environment variables (includes theming) --------------------------------------------------
 # Environment Variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XCURSOR_SIZE = "24";
  };

 #-------------------------------------------------------- Performance optimisation ---------------------------------------------------------------------
 
 # Install gamescope for game related issues
 # to optimise battery in laptops  
 # decoration:blur:enabled = false and decoration:shadow:enabled = false
 # misc:vfr = true, since it’ll lower the amount of sent frames when nothing is happening on-screen.

 # ========================================================= App configurations ================================================================================

 # For hypridle (uses listner) along with hyprlock
#  general = {
#      lock_cmd = pidof hyprlock || hyprlock;                            # avoid starting multiple hyprlock instances.
#      before_sleep_cmd = loginctl lock-session;                         # lock before suspend.
#      after_sleep_cmd = hyprctl dispatch dpms on;                       # to avoid having to press a key twice to turn on the display.
#  };

#  listener = {
#      timeout = "150";                                                  # 2.5min.
#      on-timeout = brightnessctl -s set 10;                             # set monitor backlight to minimum, avoid 0 on OLED monitor.
#      on-resume = brightnessctl -r;                                     # monitor backlight restore.
#      on-timeout = brightnessctl -sd rgb:kbd_backlight set 0;           # turn off keyboard backlight.
#     on-resume = brightnessctl -rd rgb:kbd_backlight;                  # turn on keyboard backlight.
#  };

#  listener = {
#      timeout = "300";                                                  # 5min
#      on-timeout = loginctl lock-session;                               # lock screen when timeout has passed
#  };

#  listener = {
#      timeout = "330";                                                  # 5.5min
#      on-timeout = hyprctl dispatch dpms off;                           # screen off when timeout has passed
#      on-resume = hyprctl dispatch dpms on && brightnessctl -r;         # screen on when activity is detected after timeout has fired.
#  };

#  listener = {
#      timeout = "1800";                                                 # 30min
#      on-timeout = systemctl suspend;                                   # suspend pc
#  };
 
 #------------------------------------------------------------------------------------------------------------------------------------------------------------------
 # for hyprlock

 #------------------------------------------------------------------------------------------------------------------------------------------------------------------
 # for hyprland-qt-support                                              # out of (1-3)
 # roundness = "2";
 # border_width = "1";
 # reduce_motion = true;                                                 # reduce motion of elements (transitions, hover effects, etc)
  
 #------------------------------------------------------------------------------------------------------------------------------------------------------------------

 # Rofi Configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "${pkgs.rofi}/share/rofi/themes/material.rasi";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
    };
  };

 }
