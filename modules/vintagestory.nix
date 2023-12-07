{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.vintagestory;
in {
  options = {
    services.vintagestory = {
      enable = mkEnableOption "Vintage Story Dedicated Server";

      user = mkOption {
        type = types.str;
        default = "vintagestory";
        description = lib.mdDoc ''
          User account under which vintagestory children processes run.
        '';
      };

      group = mkOption {
        type = types.str;
        default = "users";
        description = lib.mdDoc ''
          Group under which vintagestory children processes run.
        '';
      };

      dataPath = mkOption {
        type = types.str;
        default = "Vintagestory";
        description = lib.mdDoc ''
          Sets the path of the data directory
        '';
      };

      logPath = mkOption {
        type = types.str;
        default = "Logs";
        description = lib.mdDoc ''
          Sets the path of the log directory
        '';
      };

      port = mkOption {
        type = types.int;
        default = 42420;
        description = lib.mdDoc ''
          Choose the Port which you want the server to
          communicate with. Please note that this has to
          correspond with the Port Forwarding settings on
          your Router.
          Default Ports are 42420
        '';
      };

      maxClients = mkOption {
        type = types.int;
        default = 16;
        description = lib.mdDoc ''
          Maximum quantity of clients to be connected at the same
          time, overwrites configured value  (default 16)
        '';
      };

      #jsonConfig = mkOption {
      #  type = types.int;
      #  default = 16;
      #  description = lib.mdDoc ''
      #    Set a config value. Generates a serverconfig.json if it
      #    doesn't exist. Use the format --setconfig="{ key: 3, foo:
      #    'value' }"
      #  '';
      #};
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    users.users.${cfg.user} = {
      group = cfg.group;
      description = "Vintage Story user";
      shell = pkgs.bash;
      isNormalUser = true;
		  createHome = true;
    };

    networking.firewall = {
      allowedTCPPorts = [ cfg.port ];
    };

    systemd.services.vintagestory = {
      description  = "Vintate Story dedicated Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = with pkgs; [
        vintagestory
      ];
      script = ''
        cd ~

        mkdir -p {${cfg.dataPath},${cfg.logPath}}

        vintagestory-server --dataPath ${cfg.dataPath} --logPath ${cfg.logPath} --port ${builtins.toString cfg.port} --maxclients ${builtins.toString cfg.maxClients}
        ## TODO add --setconfig $ {cfg.jsonConfig}
        ## TODO Add Modding
        # --addOrigin      Tells the asset manager to also load assets from this path
        # --addModPath     Tells the mod loader to also load mods from this path

        ## Additional Options
        # --ip             Bind server to given ip, overwrites configured value (default: all ips)
        # --tracelog       Print log also via Trace.WriteLine() to get it to show up in the visual studio output window
        # --append         Do not overwrite log files
        # --genconfig      Generate a new default serverconfig.json and exit. Warning, this deletes any existing config.
      '';

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        TimeoutStartSec = "10min";
      };
    };
  };
}
