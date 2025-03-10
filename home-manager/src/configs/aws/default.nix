{ pkgs, ... }:
{
  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;
    settings = {
      default = {
        region = "ap-southeast-1";
        output = "json";
        cli_auto_prompt = "on-partial";
        cli_history = "enabled";
        cli_timestamp_format = "iso8601";
      };
    };
  };
  programs.fish.shellInit = ''
    # Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
  '';
}
