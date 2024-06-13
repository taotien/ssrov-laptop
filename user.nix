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
    shell = pkgs.nushell;
    hashedPassword = "$y$j9T$RlqMWcgUKrHtDUODWYJlL/$UyRHUuS0xJUx/I3UuBID9uqC9aPMAnUI058ca0Z5Bk9";
  };
}
