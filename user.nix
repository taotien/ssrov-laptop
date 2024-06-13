{pkgs, ...}: {
  users.users.camper.packages = with pkgs; [
    arduino-ide
    bottles
    jupyter
    onlyoffice-bin
    qgis
    vlc
  ];

  users.users.camper = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.nushell;
  };
}
