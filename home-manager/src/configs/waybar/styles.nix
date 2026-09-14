{ ... }:
let
  dir = ./configs/styles;
in
{
  default = "${dir}/default.css";
  glassy = "${dir}/glassy.css";
}
