{ ... }:

{
  # solving "Module ahci not found error",
  # from https://github.com/NixOS/nixpkgs/issues/126755
  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  nixpkgs.crossSystem.system = "armv6l-linux";

  users.mutableUsers = false;
  users.users.pi = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" ];
    password = "raspberry";
  };

  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix>
  ];
}
