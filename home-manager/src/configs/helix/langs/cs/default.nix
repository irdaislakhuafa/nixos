{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.cs;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.csharp-ls
    pkgs.dotnet-runtime
    pkgs.omnisharp-roslyn
    pkgs.netcoredbg
  ];

  programs.helix.languages = {
    language = [
      {
        name = "c-sharp";
        scope = "source.csharp";
        injection-regex = "c-?sharp";
        file-types = [
          "cs"
          "csx"
          "cake"
        ];
        roots = [
          "sln"
          "csproj"
        ];
        # comment-tokens = [
        #   "//"
        #   "///"
        # ];
        block-comment-tokens = {
          start = "/*";
          end = "*/";
        };
        indent = {
          tab-width = 4;
          unit = "\t";
        };
        language-servers = [
          # "omnisharp"
          "csharp-ls"
        ];
        debugger = {
          name = "netcoredbg";
          transport = "tcp";
          command = "netcoredbg";
          args = [ "--interpreter=vscode" ];
          port-arg = "--server={}";
          templates = [
            {
              name = "launch";
              request = "launch";
              completion = [
                {
                  name = "path to dll";
                  completion = "filename";
                }
              ];
              args = {
                type = "coreclr";
                console = "internalConsole";
                internalConsoleOptions = "openOnSessionStart";
                program = "{0}";
              };
            }
            {
              name = "attach";
              request = "attach";
              completion = [ "pid" ];
              args = {
                processId = "{0}";
              };
            }
          ];
        };
      }
    ];
    language-servers = {
      omnisharp = {
        command = "OmniSharp";
        args = [ "--languageserver" ];
      };
      csharp-ls = {
        command = "csharp-ls";
      };
    };
  };
}
