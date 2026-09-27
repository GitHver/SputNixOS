{ lib
, config
, ...
}:

let
  inherit (lib) mkOption;
  inherit (lib.types) str;
  cfg = config.localization;
in {

  options.localization = {
    language = mkOption {
      default = "en_GB";
      type = str;
      description = "The system language";
    };
    formatting = mkOption {
      default = "en_GB";
      type = str;
      description = "The system formatting. Time, date, metrics, currency, etc";
    };
    timezone = mkOption {
      default = "Europe/London";
      type = str;
      description = "The time zone you are located in";
    };
  };

  config = {
    i18n.defaultLocale = cfg.language;
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = cfg.formatting;
      LC_IDENTIFICATION = cfg.formatting;
      LC_MEASUREMENT    = cfg.formatting;
      LC_MONETARY       = cfg.formatting;
      LC_NAME           = cfg.formatting;
      LC_NUMERIC        = cfg.formatting;
      LC_PAPER          = cfg.formatting;
      LC_TELEPHONE      = cfg.formatting;
      LC_TIME           = cfg.formatting;
    };
    time.timeZone = cfg.timezone;
  };

}
