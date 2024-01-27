{lib, ...}: 
{
  importNix = dir: 
    with builtins; 
      concatMap (path: import path) (
        filter (path: hasSuffix ".nix" path) (
	  readDir dir
        )
      );
}
