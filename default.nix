host-name:
imports:

{ lib, config, pkgs, ... }@module-args:
let

  inherit (builtins) readDir attrNames foldl';
  inherit (lib) filterAttrs hasPrefix hasSuffix recursiveUpdate;

  list-all-imports =
    path:
    let
      dir-content =
        filterAttrs
        (
          file-name: file-type:
          file-type == "regular" &&
          hasPrefix "conf." file-name &&
          hasSuffix ".nix" file-name
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
      my-module-args = module-args // { inherit configuration; };
      include-file = file: import file my-module-args;
    in
      foldl' recursiveUpdate {}
      (
        [
          {
            imports = imports;
            networking.hostName = "nixos";
          }
          (include-file (./. + "/host.${host-name}.nix"))
        ] ++ (
          map include-file (list-all-imports ./.)
        )
      );

  Y = X: X (Y X);

in
  Y gen-configuration
