{ pkgs, ... }:
let
  fetchedPinnedPkgs = builtins.fetchTarball rec {
    url = "https://github.com/NixOS/nixpkgs/archive/da289b19d0cbe59c3d3a060bcc990dc955124c64.tar.gz";
    sha256 = "0yw56b5xvf4vjbn6ss5g7ibnrsadmy10qhggw5h0ncx2klv7827m";
  };
  pinnedPkgs = import fetchedPinnedPkgs {
    inherit (pkgs) system config;
  };
  defaultPage = "file://${builtins.toPath ./startpage.html}";
in

{
  nixpkgs.overlays = [
    (final: prev: { qutebrowser = pinnedPkgs.qutebrowser.override { enableWideVine = true; }; })
  ];
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.wayland}/lib:$LD_LIBRARY_PATH";
  };
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://search.brave.com/search?q={}";
    };
    settings = {
      # Always restore open sites when qutebrowser is reopened. Without this
      # option set, `:wq` (`:quit --save`) needs to be used to save open tabs
      # (and restore them), while quitting qutebrowser in any other way will
      # not save/restore the session. By default, this will save to the
      # session which was last loaded. This behavior can be customized via the
      # `session.default_name` setting.
      # Type: Bool
      auto_save.session = true;

      completion.show = "always";

      # Backend to use to display websites. qutebrowser supports two different
      # web rendering engines / backends, QtWebEngine and QtWebKit (not
      # recommended). QtWebEngine is Qt's official successor to QtWebKit, and
      # both the default/recommended backend. It's based on a stripped-down
      # Chromium and regularly updated with security fixes and new features by
      # the Qt project: https://wiki.qt.io/QtWebEngine QtWebKit was
      # qutebrowser's original backend when the project was started. However,
      # support for QtWebKit was discontinued by the Qt project with Qt 5.6 in
      # 2016. The development of QtWebKit was picked up in an official fork:
      # https://github.com/qtwebkit/qtwebkit - however, the project seems to
      # have stalled again. The latest release (5.212.0 Alpha 4) from March
      # 2020 is based on a WebKit version from 2016, with many known security
      # vulnerabilities. Additionally, there is no process isolation and
      # sandboxing. Due to all those issues, while support for QtWebKit is
      # still available in qutebrowser for now, using it is strongly
      # discouraged.
      # Type: String
      # Valid values:
      #   - webengine: Use QtWebEngine (based on Chromium - recommended).
      #   - webkit: Use QtWebKit (based on WebKit, similar to Safari - many known security issues!).
      backend = "webengine";

      # Additional arguments to pass to Qt, without leading `--`. With
      # QtWebEngine, some Chromium arguments (see
      # https://peter.sh/experiments/chromium-command-line-switches/ for a
      # list) will work.
      # Type: List of String
      qt.args = [
        "js-flags=--predictable-gc-schedule"
        "js-flags=--trace-gc"
        "ignore-gpu-blocklist"
        "enable-gpu-rasterization"
        "enable-accelerated-video-decode"
        "enable-zero-copy"
        "num-raster-threads=4"
      ];

      # Which Chromium process model to use. Alternative process models use
      # less resources, but decrease security and robustness. See the
      # following pages for more details:    -
      # https://www.chromium.org/developers/design-documents/process-models
      # - https://doc.qt.io/qt-6/qtwebengine-features.html#process-models
      # Type: String
      # Valid values:
      #   - process-per-site-instance: Pages from separate sites are put into separate processes and separate visits to the same site are also isolated.
      #   - process-per-site: Pages from separate sites are put into separate processes. Unlike Process per Site Instance, all visits to the same site will share an OS process. The benefit of this model is reduced memory consumption, because more web pages will share processes. The drawbacks include reduced security, robustness, and responsiveness.
      #   - single-process: Run all tabs in a single process. This should be used for debugging purposes only, and it disables `:open --private`.
      qt.chromium.process_model = "single-process";

      # Enables Web Platform features that are in development. This passes the
      # `--enable-experimental-web-platform-features` flag to Chromium. By
      # default, this is enabled with Qt 5 to maximize compatibility despite
      # an aging Chromium base.
      # Type: String
      # Valid values:
      #   - always: Enable experimental web platform features.
      #   - auto: Enable experimental web platform features when using Qt 5.
      #   - never: Disable experimental web platform features.
      qt.chromium.experimental_web_platform_features = "always";

      # Disable accelerated 2d canvas to avoid graphical glitches. On some
      # setups graphical issues can occur on sites like Google sheets and
      # PDF.js. These don't occur when accelerated 2d canvas is turned off, so
      # we do that by default. So far these glitches only occur on some Intel
      # graphics devices.
      # Type: String
      # Valid values:
      #   - always: Disable accelerated 2d canvas
      #   - auto: Disable on Qt6 < 6.6.0, enable otherwise
      #   - never: Enable accelerated 2d canvas
      qt.workarounds.disable_accelerated_2d_canvas = "never";

      qt.force_platform = "wayland";

      input.insert_mode.auto_enter = true;
      input.insert_mode.auto_leave = true;
      input.insert_mode.auto_load = true;
      input.insert_mode.leave_on_load = true;
      input.insert_mode.plugins = true;

      tabs.show = "never";

      window.hide_decoration = true;
      window.transparent = true;

      content.fullscreen.window = true;

      # Where to show the downloaded files.
      # Type: VerticalPosition
      # Valid values:
      #   - top
      #   - bottom
      downloads.position = "bottom";

      # Duration (in milliseconds) to wait before removing finished downloads.
      # If set to -1, downloads are never removed.
      # Type: Int
      downloads.remove_finished = -1;

      # Editor (and arguments) to use for the `edit-*` commands. The following
      # placeholders are defined:  * `{file}`: Filename of the file to be
      # edited. * `{line}`: Line in which the caret is found in the text. *
      # `{column}`: Column in which the caret is found in the text. *
      # `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
      # Same as `{column}`, but starting from index 0.
      # Type: ShellCommand
      editor.command = [
        "kitty"
        "-e"
        "hx"
        "{file}:{line}:{column0}"
      ];

      # Mode to use for hints.
      # Type: String
      # Valid values:
      #   - number: Use numeric hints. (In this mode you can also type letters from the hinted element to filter and reduce the number of elements that are hinted.)
      #   - letter: Use the characters in the `hints.chars` setting.
      #   - word: Use hints words based on the html elements and the extra words.
      hints.mode = "letter";

      # When/how to show the scrollbar.
      # Type: String
      # Valid values:
      #   - always: Always show the scrollbar.
      #   - never: Never show the scrollbar.
      #   - when-searching: Show the scrollbar when searching for text in the webpage. With the QtWebKit backend, this is equal to `never`.
      #   - overlay: Show an overlay scrollbar. On macOS, this is unavailable and equal to `when-searching`; with the QtWebKit backend, this is equal to `never`. Enabling/disabling overlay scrollbars requires a restart.
      scrolling.bar = "always";

      # Enable smooth scrolling for web pages. Note smooth scrolling does not
      # work with the `:scroll-px` command.
      # Type: Bool
      scrolling.smooth = false;

      # When to show the statusbar.
      # Type: String
      # Valid values:
      #   - always: Always show the statusbar.
      #   - never: Always hide the statusbar.
      #   - in-mode: Show the statusbar when in modes other than normal mode.
      statusbar.show = "always";

      # How to behave when the last tab is closed. If the
      # `tabs.tabs_are_windows` setting is set, this is ignored and the
      # behavior is always identical to the `close` value.
      # Type: String
      # Valid values:
      #   - ignore: Don't do anything.
      #   - blank: Load a blank page.
      #   - startpage: Load the start page.
      #   - default-page: Load the default page.
      #   - close: Close the window.
      tabs.last_close = "default-page";

      # Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
      # for a blank page.
      # Type: FuzzyUrl
      # url.default_page = "https://search.brave.com/";
      url.default_page = defaultPage;
      url.start_pages = defaultPage;

      # Width (in pixels) of the progress indicator (0 to disable).
      # Type: Int
      tabs.indicator.width = 3;

      # Value to use for `prefers-color-scheme:` for websites. The "light"
      # value is only available with QtWebEngine 5.15.2+. On older versions,
      # it is the same as "auto". The "auto" value is broken on QtWebEngine
      # 5.15.2 due to a Qt bug. There, it will fall back to "light"
      # unconditionally.
      # Type: String
      # Valid values:
      #   - auto: Use the system-wide color scheme setting.
      #   - light: Force a light theme.
      #   - dark: Force a dark theme.
      colors.webpage.preferred_color_scheme = "dark";

      # Render all web contents using a dark theme. On QtWebEngine < 6.7, this
      # setting requires a restart and does not support URL patterns, only the
      # global setting is applied. Example configurations from Chromium's
      # `chrome://flags`: - "With simple HSL/CIELAB/RGB-based inversion": Set
      # `colors.webpage.darkmode.algorithm` accordingly, and   set
      # `colors.webpage.darkmode.policy.images` to `never`.  - "With selective
      # image inversion": qutebrowser default settings.
      # Type: Bool
      colors.webpage.darkmode.enabled = false;
    };
  };
}
