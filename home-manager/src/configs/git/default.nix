{ pkgs, ... }:
{
  home.packages = [
    pkgs.meld
  ];

  programs.git = {
    enable = true;
    userName = "Irda Islakhu Afa";
    userEmail = "irdhaislakhuafa@gmail.com";
    lfs = {
      enable = true;
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        navigate = true;
        dark = true;
      };
    };
    extraConfig = {
      merge = {
        "hx" =
          let
            original = "%O";
            ancestor = "%A";
            conflict = "%B";
          in
          {
            name = "Resolve merge conflict with helix";
            driver = "${pkgs.helix}/bin/hx --vsplit ${original} ${ancestor} ${conflict}";
          };
      };
      credential = {
        helper = "store";
      };
      diff = {
        tool = "meld";
      };
    };
  };
}
