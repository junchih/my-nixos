module-args:

with builtins;

let

  lib = module-args.lib;

  list-all-imports =
    path:
    let

      dir-content = readDir path;

      file-and-types =
        map
        (name: { file = name; type = getAttr name dir-content; })
        (attrNames dir-content);

      import-list =
        map (f: path + ("/" + f.file))
        (
          filter
          (
            f:
            (f.type == "regular") &&
            (lib.hasPrefix "conf." f.file) &&
            (lib.hasSuffix ".nix" f.file)
          )
          file-and-types
        );

    in import-list;

  include-file = file: (import file) module-args;

in

  foldl' lib.recursiveUpdate {}
  (
    map include-file (list-all-imports ./.)
  )
