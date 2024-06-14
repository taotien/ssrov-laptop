{pkgs, ...}: {
  users.users.camper.packages = with pkgs; [
    arduino-ide
    onlyoffice-bin
    qgis
    saga
    sonic-visualiser
    vlc
    (python311Full.withPackages (ps:
      with ps; [
        jupyter

        bokeh
        datashader
        hvplot
        ipywidgets
        linkify-it-py
        markdown-it-py
        mdit-py-plugins
        nbclient
        numpy
        pandas
        panel
        plotly
        pyparsing
        pyserial
        scikit-learn
        scipy
        streamz
        tkinter
      ]))
  ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  users.users.camper = {
    isNormalUser = true;
    shell = pkgs.nushell;
    hashedPassword = "$y$j9T$RlqMWcgUKrHtDUODWYJlL/$UyRHUuS0xJUx/I3UuBID9uqC9aPMAnUI058ca0Z5Bk9";
  };
}
