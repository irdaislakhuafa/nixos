{ ... }:
let
  dir = ./configs/styles;
in
{
  default = "${dir}/default.css";
  glassy_light = "${dir}/glassy_light.css";
  glassy_night = "${dir}/glassy_night.css";
}
