{ ... }:
let
  dir = ./configs/styles;
in
{
  default = "${dir}/default.css";
  glassy_light = "${dir}/glassy_light.css";
  glassy_night = "${dir}/glassy_night.css";
  glassy_night_minimal = "${dir}/glassy_night_minimal.css";
  one_ui = "${dir}/one_ui.css";
  samsung_oneui = "${dir}/one_ui.css";
}
