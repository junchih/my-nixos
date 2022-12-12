{ lib, config, pkgs, ... }:

with builtins;

let

  list-user-files =
    path:
    let
      file-names =
        filter
        (file-name: lib.hasSuffix ".nix" file-name)
        (attrNames (readDir path));
    in
      map
      (file-name: {
        user = lib.removeSuffix ".nix" file-name;
        file = path + ("/" + file-name);
      })
      file-names;

  include-file = file: import file { inherit lib config pkgs; };

  read-user-confs =
    user-files:
    map
    ({user, file}: { user = user; conf = include-file file; })
    user-files;

in

{
  # Set immutable user configurations
  users.mutableUsers = false;
  # Set zsh as the user default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # Set global environment variables
  environment.variables.CLICOLOR = "1";
  environment.variables.LSCOLORS = "gxBxhxDxfxhxhxhxhxcxcx";
  # set ~/bin into $PATH
  environment.homeBinInPath = true;

  users.users =
    let
      user-confs = read-user-confs (list-user-files ./users.d);
      kv-pairs = map ({user, conf}: {name = user; value = conf;}) user-confs;
      users-conf = listToAttrs kv-pairs;
    in
      users-conf;
}
