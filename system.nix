{
  inputs,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    cifs-utils
    du-dust
    exfatprogs
    fastfetch
    ffmpeg
    firefox
    git
    helix
    localsend
    mesa
    # mpv
    oculante
    ouch
    ripgrep
    skim
    tree
    wezterm
    wget
    zellij
    zstd
  ];

  programs.firefox.enable = true;
  programs.firefox.policies = {
    DisablePocket = true;
    PasswordManagerEnabled = false;
    NoDefaultBookmarks = false;
  };
  programs.firefox.preferences = {
    "media.ffmpeg.vaapi.enabled" = true;

    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "widget.use-xdg-desktop-portal.location" = 1;
    "widget.use-xdg-desktop-portal.mime-handler" = 1;
    "widget.use-xdg-desktop-portal.open-uri" = 1;
    "widget.use-xdg-desktop-portal.settings" = 1;

    "accessibility.browsewithcaret_shortcut.enabled" = false;
    "browser.bookmarks.restore_default_bookmarks" = false;
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  systemd.services.display-manager.restartIfChanged = false;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "camper";
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs; [
    elisa
    konsole
    gwenview
    kate
    xterm
  ];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  services.tailscale.enable = true;

  services.smartd.enable = true;
  services.btrfs.autoScrub.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    PAGER = "bat";
    SKIM_DEFAULT_COMMAND = "rg --files";
  };
  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    PAGER = "bat";
    SKIM_DEFAULT_COMMAND = "rg --files";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKLOGhoTauV+yBide0qYQzZ/0rRw7ImfrOTvuZxjIFl"
  ];
  users.users.root.hashedPassword = "$y$j9T$HtffbZMQD7RrZoCIS/gge1$bP5qxgomfi508emW85s.Cci9Xi9zoWfSQVEdRxdoJl0";

  users.mutableUsers = false;

  time.timeZone = lib.mkDefault "US/Pacific";
  # services.automatic-timezoned.enable = lib.mkDefault true;
  # i18n.extraLocaleSettings = {
  # LC_CTYPE = "en_US.UTF-8";
  # LC_MESSAGES = "en_US.UTF-8";
  # LC_ALL = "en_US.UTF-8";
  # };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  powerManagement.cpuFreqGovernor = "powersave";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = lib.mkForce 1;
  boot.supportedFilesystems = ["btrfs"];
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "uas" "sd_mod"];

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;

  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    trusted-users = ["root" "@wheel"];
  };
  nixpkgs.config = {allowUnfree = true;};

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = lib.mkDefault "23.05";
}
