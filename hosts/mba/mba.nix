{
  settings,
  specialArgs,
  ...
}: {
  imports = [
    ./../common/darwin.nix
  ];

  home-manager = {
    backupFileExtension = "bak";
    users.${settings.name}.imports = [
      specialArgs.inputs.mac-app-util.homeManagerModules.default
      ../${settings.hostname}/${settings.hostname}-home.nix
    ];
    extraSpecialArgs = specialArgs;
  };
}
