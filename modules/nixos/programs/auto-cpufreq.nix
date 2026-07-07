{
  # auto-cpufreq dynamically switches the CPU governor/EPP between a
  # power-saving profile at idle and a performance profile under load,
  # instead of pinning a single static governor like schedutil.
  services.auto-cpufreq = {
    enable = true;

    settings = {
      # Used whenever the system is under low/no load -> keeps the 5950x
      # cool and quiet at idle.
      battery = {
        governor = "powersave";
        turbo = "auto";
      };

      # Used under load (gaming, compiling, etc). "performance" governor +
      # turbo = "auto" lets the CPU boost as high as thermals/power allow,
      # while still letting auto-cpufreq pull it back down once load drops.
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
