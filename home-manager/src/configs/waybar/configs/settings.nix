{ pkgs, ... }: [
  {
    output = [
      "eDP-1"
    ];
    layer = "top";
    position = "top"; # Waybar position (top|bottom|left|right)
    spacing = 5; # Gaps between modules (4px)
    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
      "hyprland/submap"
      "hyprland/scratchpad"
      "custom/media"
    ];
    modules-center = [
      "custom/clock"
    ];
    modules-right = [
      "pulseaudio"
      "network"
      "cpu"
      "custom/memory"
      "temperature"
      "backlight"
      "battery"
      "tray"
    ];
    "wlr/workspaces" = {
      "disable-scroll" = false;
      "all-outputs" = false;
      "on-click" = "activate";
      "format" = "{name}";
      "sort-by-number" = true;
      "sort-by-name" = false;
      "sort-by-coordinates" = false;
      "active-only" = false;
      "format-icons" = {
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "";
        "5" = "";
        "urgent" = "";
        "focused" = "";
        "default" = "";
      };
    };
    keyboard-state = {
      numlock = true;
      capslock = true;
      format = "{name} {icon}";
      format-icons = {
        locked = "";
        unlocked = "";
      };
    };
    "hyprland/submap" = {
      format = ''Workspace Mode <span style="normal"> >> {} </span>'';
    };
    "hyprland/scratchpad" = {
      format = "{icon} {count}";
      show-empty = false;
      format-icons = [
        ""
        ""
      ];
      tooltip = true;
      tooltip-format = "{app}: {title}";
    };
    "hyprland/window" = {
      separate-outputs = true;
      format = "{}";
      max-length = 30;
      show-empty = false;
    };
    mpd = {
      format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
      format-disconnected = "Disconnected ";
      format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      unknown-tag = "N/A";
      interval = 2;
      consume-icons = {
        on = " ";
      };
      random-icons = {
        off = "<span color=\"#f53c3c\"></span> ";
        on = " ";
      };
      repeat-icons = {
        on = " ";
      };
      single-icons = {
        on = "1 ";
      };
      state-icons = {
        paused = "";
        playing = "";
      };
      tooltip-format = "MPD (connected)";
      tooltip-format-disconnected = "MPD (disconnected)";
    };
    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    tray = {
      spacing = 10;
    };
    cpu = {
      format = " {usage}%";
      tooltip = false;
    };
    temperature = {
      # "thermal-zone= 2,
      # "hwmon-path= "/sys/class/hwmon/hwmon2/temp1_input",
      critical-threshold = 80;
      # "format-critical= "{temperatureC}°C {icon}",
      format = "{icon} {temperatureC}°C";
      format-icons = [
        ""
        ""
        ""
      ];
    };
    backlight = {
      # "device= "acpi_video1",
      format = "{icon}  {percent}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };
    battery = {
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = " {capacity}%";
      format-plugged = " {capacity}%";
      format-alt = "{time} {icon}";
      # "format-good": "", # An empty format will hide the module
      # "format-full": "",
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      design-capacity = true;
    };
    "battery#bat2" = {
      bat = "BAT2";
    };
    network = {
      # "interface= "wlp2*", # (Optional) To force the use of this interface
      format-wifi = "  {essid} ({signalStrength}%)";
      format-ethernet = "  {ipaddr}/{cidr}";
      tooltip-format = "  {ifname} via {gwaddr}";
      format-linked = "  {ifname} (No IP)";
      format-disconnected = "⚠ Disconnected :(";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };
    pulseaudio = {
      scroll-step = 1; # %, can be a float
      format = "{icon}  {volume}%  {format_source}";
      format-bluetooth = "{icon} {volume}%  {format_source}";
      format-bluetooth-muted = "  {icon}  {format_source}";
      format-muted = "  {format_source}";
      format-source = " {volume}%";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };
      on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
    };
    "custom/memory" = {
      format = "{}";
      interval = 1;
      exec = (
        let
          free = "${pkgs.procps}/bin/free";
          grep = "${pkgs.gnugrep}/bin/grep";
          awk = "${pkgs.gawk}/bin/awk";
        in
        ''
          used=$(${free} -hm | ${grep} Mem: | ${awk} '{print $3}')B;
          free=$(${free} -hm | ${grep} Mem: | ${awk} '{print $7}')B;
          echo "$used/$free"
        ''
      );
    };
    "custom/clock" = {
      format = "{}";
      interval = 1;
      exec = "${pkgs.coreutils-full}/bin/date '+%A, %d %B %Y | %H:%M:%S'";
    };
  }
]
