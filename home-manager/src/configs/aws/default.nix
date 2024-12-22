{ pkgs, ... }:
{
  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;
    settings = {
      default = {
        region = "us-east-1";
        output = "json";
        cli_auto_prompt = "on-partial";
        cli_history = "enabled";
        cli_timestamp_format = "iso8601";
      };
    };
  };
}
