host-name:
hardware:

{ lib, config, pkgs, ...}:
with builtins;

let

  list-all-imports =
    path:
    let
      dir-content =
        lib.filterAttrs
        (
          file-name: file-type:
          file-type == "regular" &&
          lib.hasPrefix "conf." file-name &&
          lib.hasSuffix ".nix" file-name
        )
        (readDir path);
      import-list =
        map
        (file-name: path + ("/" + file-name))
        (attrNames dir-content);
    in import-list;

  gen-configuration =
    configuration:
    let
      my-module-args = { inherit lib config pkgs configuration; };
      include-file = file: import file my-module-args;
    in
      foldl' lib.recursiveUpdate {}
      (
        [
          { imports = [ hardware ]; }
          (include-file (./. + "/${host-name}.nix"))
        ] ++ (
          map include-file (list-all-imports ./.)
        )
      );

  Y = X: X (Y X);

in
  Y gen-configuration
