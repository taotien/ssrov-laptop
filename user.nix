{pkgs, ...}: {
  users.users.camper.packages = with pkgs; [
    arduino-ide
    bottles
    # jupyter
    onlyoffice-bin
    qgis
    vlc
    sonic-visualiser
    saga
    (python311Full.withPackages (ps:
      with ps; [
        panel
        ipywidgets
        jupyter
        pandas
        numpy
        plotly
        pyserial
        pyparsing
        nbclient
        ipywidgets
        bokeh
        hvplot
        datashader
        scipy
        scikit-learn
        streamz
        tkinter
      ]))
  ];

  users.users.camper = {
    isNormalUser = true;
    shell = pkgs.nushell;
    hashedPassword = "$y$j9T$RlqMWcgUKrHtDUODWYJlL/$UyRHUuS0xJUx/I3UuBID9uqC9aPMAnUI058ca0Z5Bk9";
  };
}
