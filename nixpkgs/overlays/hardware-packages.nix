self: super:

{
  hardware-packages = super.pkgs.buildEnv {
    name = "hardware-packages";
    paths = with super.pkgs; [
      dmidecode
      edid-decode
      lm_sensors
      powertop
      smartmontools
    ];
  };
}
