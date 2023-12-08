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

      jsonConfig = mkOption {
        type = types.str;
        default = ''
        {
          "ConfigVersion": "1.4",
          "ServerMonitor": true,
          "PassTimeWhenEmpty": false,
          "MasterserverUrl": "http://masterserver.vintagestory.at/api/v1/servers/",
          "ModDbUrl": "https://mods.vintagestory.at/",
          "ClientConnectionTimeout": 150,
          "EntityDebugMode": false,
          "MapSizeX": 1024000,
          "MapSizeY": 256,
          "MapSizeZ": 1024000,
          "ServerLanguage": "en",
          "SkipEveryChunkRow": 0,
          "SkipEveryChunkRowWidth": 0,
          "ModPaths": [
            "Mods",
            "Vintagestory/Mods"
          ],
          "WorldConfig": {
            "Seed": null,
            "SaveFileLocation": "Vintagestory/Saves/default.vcdbs",
            "WorldName": "A new world",
            "AllowCreativeMode": true,
            "PlayStyle": "surviveandbuild",
            "PlayStyleLangCode": "surviveandbuild-bands",
            "WorldType": "standard",
            "WorldConfiguration": null,
            "MapSizeY": null,
            "CreatedByPlayerName": null,
            "DisabledMods": null,
            "RepairMode": false
          },
          "NextPlayerGroupUid": 10,
          "GroupChatHistorySize": 20,
          "MaxOwnedGroupChannelsPerUser": 10,
          "ServerName": "Vintage Story Server",
          "ServerUrl": null,
          "ServerDescription": null,
          "WelcomeMessage": "Welcome {0}, may you survive well and prosper",
          "Ip": null,
          "Port": 42420,
          "Upnp": false,
          "CompressPackets": true,
          "AdvertiseServer": true,
          "MaxClients": 16,
          "Password": null,
          "MaxChunkRadius": 12,
          "TickTime": 33.3333321,
          "SpawnCapPlayerScaling": 0.75,
          "BlockTickChunkRange": 4,
          "MaxMainThreadBlockTicks": 10000,
          "RandomBlockTicksPerChunk": 16,
          "BlockTickInterval": 300,
          "Roles": [
            {
              "Code": "suvisitor",
              "Name": "Survival Visitor",
              "Description": "Can only visit this world and chat but not use/place/break anything",
              "PrivilegeLevel": -1,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "chat"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 1,
              "Color": "Green",
              "LandClaimAllowance": 0,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 3,
              "AutoGrant": false
            },
            {
              "Code": "crvisitor",
              "Name": "Creative Visitor",
              "Description": "Can only visit this world, chat and fly but not use/place/break anything",
              "PrivilegeLevel": -1,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "chat"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 2,
              "Color": "DarkGray",
              "LandClaimAllowance": 0,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 3,
              "AutoGrant": false
            },
            {
              "Code": "limitedsuplayer",
              "Name": "Limited Survival Player",
              "Description": "Can use/place/break blocks only in permitted areas (priv level -1), create/manage player groups and chat",
              "PrivilegeLevel": -1,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "controlplayergroups",
                "manageplayergroups",
                "chat",
                "build",
                "useblock",
                "attackcreatures",
                "attackplayers"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 1,
              "Color": "White",
              "LandClaimAllowance": 0,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 3,
              "AutoGrant": false
            },
            {
              "Code": "limitedcrplayer",
              "Name": "Limited Creative Player",
              "Description": "Can use/place/break blocks in only in permitted areas (priv level -1), create/manage player groups, chat, fly and set his own game mode (= allows fly and change of move speed)",
              "PrivilegeLevel": -1,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "controlplayergroups",
                "manageplayergroups",
                "chat",
                "build",
                "useblock",
                "gamemode",
                "freemove",
                "attackcreatures",
                "attackplayers"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 2,
              "Color": "LightGreen",
              "LandClaimAllowance": 0,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 3,
              "AutoGrant": false
            },
            {
              "Code": "suplayer",
              "Name": "Survival Player",
              "Description": "Can use/place/break blocks in unprotected areas (priv level 0), create/manage player groups and chat. Can claim an area of up to 8 chunks.",
              "PrivilegeLevel": 0,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "controlplayergroups",
                "manageplayergroups",
                "chat",
                "areamodify",
                "build",
                "useblock",
                "attackcreatures",
                "attackplayers"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 1,
              "Color": "White",
              "LandClaimAllowance": 262144,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 3,
              "AutoGrant": false
            },
            {
              "Code": "crplayer",
              "Name": "Creative Player",
              "Description": "Can use/place/break blocks in all areas (priv level 100), create/manage player groups, chat, fly and set his own game mode (= allows fly and change of move speed). Can claim an area of up to 40 chunks.",
              "PrivilegeLevel": 100,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "controlplayergroups",
                "manageplayergroups",
                "chat",
                "areamodify",
                "build",
                "useblock",
                "gamemode",
                "freemove",
                "attackcreatures",
                "attackplayers"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 2,
              "Color": "LightGreen",
              "LandClaimAllowance": 1310720,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 6,
              "AutoGrant": false
              },
              {
                "Code": "sumod",
                "Name": "Survival Moderator",
                "Description": "Can use/place/break blocks everywhere (priv level 200), create/manage player groups, chat, kick/ban players and do serverwide announcements. Can claim an area of up to 4 chunks.",
                "PrivilegeLevel": 200,
                "DefaultSpawn": null,
                "ForcedSpawn": null,
                "Privileges": [
                  "controlplayergroups",
                  "manageplayergroups",
                  "chat",
                  "areamodify",
                  "build",
                  "useblock",
                  "buildblockseverywhere",
                  "useblockseverywhere",
                  "kick",
                  "ban",
                  "announce",
                  "readlists",
                  "attackcreatures",
                  "attackplayers"
                ],
                "RuntimePrivileges": [],
                "DefaultGameMode": 1,
                "Color": "Cyan",
                "LandClaimAllowance": 1310720,
                "LandClaimMinSize": {
                  "X": 5,
                  "Y": 5,
                  "Z": 5
                },
                "LandClaimMaxAreas": 60,
                "AutoGrant": false
              },
              {
                "Code": "crmod",
                "Name": "Creative Moderator",
                "Description": "Can use/place/break blocks everywhere (priv level 500), create/manage player groups, chat, kick/ban players, fly and set his own or other players game modes (= allows fly and change of move speed). Can claim an area of up to 40 chunks.",
                "PrivilegeLevel": 500,
                "DefaultSpawn": null,
                "ForcedSpawn": null,
                "Privileges": [
                  "controlplayergroups",
                  "manageplayergroups",
                  "chat",
                  "areamodify",
                  "build",
                  "useblock",
                  "buildblockseverywhere",
                  "useblockseverywhere",
                  "kick",
                  "ban",
                  "gamemode",
                  "freemove",
                  "commandplayer",
                  "announce",
                  "readlists",
                  "attackcreatures",
                  "attackplayers"
                ],
               "RuntimePrivileges": [],
              "DefaultGameMode": 2,
              "Color": "Cyan",
              "LandClaimAllowance": 1310720,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 60,
              "AutoGrant": false
            },
            {
              "Code": "admin",
              "Name": "Admin",
              "Description": "Has all privileges, including giving other players admin status.",
              "PrivilegeLevel": 99999,
              "DefaultSpawn": null,
              "ForcedSpawn": null,
              "Privileges": [
                "build",
                "useblock",
                "buildblockseverywhere",
                "useblockseverywhere",
                "attackplayers",
                "attackcreatures",
                "freemove",
                "gamemode",
                "pickingrange",
                "chat",
                "kick",
                "ban",
                "whitelist",
                "setwelcome",
                "announce",
                "readlists",
                "give",
                "areamodify",
                "setspawn",
                "controlserver",
                "tp",
                "time",
                "grantrevoke",
                "root",
                "commandplayer",
                "controlplayergroups",
                "manageplayergroups"
              ],
              "RuntimePrivileges": [],
              "DefaultGameMode": 1,
              "Color": "LightBlue",
              "LandClaimAllowance": 2147483647,
              "LandClaimMinSize": {
                "X": 5,
                "Y": 5,
                "Z": 5
              },
              "LandClaimMaxAreas": 99999,
              "AutoGrant": true
            }
          ],
          "DefaultRoleCode": "suplayer",
          "AntiAbuse": 0,
          "OnlyWhitelisted": false,
          "VerifyPlayerAuth": true,
          "DefaultSpawn": null,
          "AllowPvP": true,
          "AllowFireSpread": true,
          "AllowFallingBlocks": true,
          "HostedMode": false,
          "StartupCommands": null,
          "RepairMode": false,
          "AnalyzeMode": false,
          "CorruptionProtection": true,
          "RegenerateCorruptChunks": false,
          "ChatRateLimitMs": 1000,
          "DieBelowDiskSpaceMb": 400
        }
        '';
        description = lib.mdDoc ''
          Set a config value. Generates a serverconfig.json if it
          doesn't exist. Use the format --setconfig="{ key: 3, foo:
          'value' }"
        '';
      };
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
        cat << EOF > ${cfg.dataPath}/serverconfig.json
        ${cfg.jsonConfig}
        EOF

        vintagestory-server --dataPath ${cfg.dataPath} --logPath ${cfg.logPath} --port ${builtins.toString cfg.port} --maxclients ${builtins.toString cfg.maxClients}

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
