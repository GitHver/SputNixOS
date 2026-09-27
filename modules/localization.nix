{ config
, lib
, ...
}:

let
  inherit (lib) mkOption;
  # inherit (patt) language formatting timezone;
  # name = "formatting";
  cfg = config.localization;
in {

  options.localization = {
    language = mkOption {
      default = "en_GB";
    };
    formatting = mkOption {
      default = "en_GB";
    };
    timezone = mkOption {
      default = "Europe/London";
    };
  };

  config = {
    i18n.defaultLocale = "${cfg.language}" + ".UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = "${cfg.language}" + ".UTF-8";
      LC_IDENTIFICATION = "${cfg.language}" + ".UTF-8";
      LC_MEASUREMENT    = "${cfg.language}" + ".UTF-8";
      LC_MONETARY       = "${cfg.language}" + ".UTF-8";
      LC_NAME           = "${cfg.language}" + ".UTF-8";
      LC_NUMERIC        = "${cfg.language}" + ".UTF-8";
      LC_PAPER          = "${cfg.language}" + ".UTF-8";
      LC_TELEPHONE      = "${cfg.language}" + ".UTF-8";
      LC_TIME           = "${cfg.language}" + ".UTF-8";
    };
    time.timeZone = "${cfg.timezone}";
  };

}
