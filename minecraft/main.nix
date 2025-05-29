{pkgs, ...}: {
  config = {
    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers.bonkworld = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_5;
        autoStart = true;
        openFirewall = true;
        enableReload = true;
        jvmOpts = "-Xmx4G -Xms2G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+UseZGC";

        serverProperties = {
          motd = "Bienvenue sur Bonk World!";
          difficulty = "normal";
          level-name = "bonkworld";
          enable-command-block = true;
          max-players = 50;
          enforce-secure-profile = false;
          view-distance = 12;
          spawn-protection = 0;
          log-ips = false;
          op-permission-level = 3;
          resource-pack = "https://cdn.modrinth.com/data/tpehi7ww/versions/jHLhATWl/DnT%20v4.7.zip";
          resource-pack-hash = "05ca2ecbb68b19b0da11ebda79cec5646ac01f94";
        };

        symlinks = {
          "mods" = with pkgs;
            linkFarmFromDrvs "mods" (
              builtins.attrValues {
                Fabric-API = fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/w6P5mySo/fabric-api-0.125.0%2B1.21.5.jar";
                  sha512 = "159cf97b0869c923e3b7f477db8eefe70e4a4906f3663ac4e9c23e4237bbd0e07d79405de6b323a7a9989c76d33959770ba499abba12c90d64ca710c079b2bc7";
                };
                Ferrite-Core = fetchurl {
                  url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
                  sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745";
                };
                Lithium = fetchurl {
                  url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/VWYoZjBF/lithium-fabric-0.16.2%2Bmc1.21.5.jar";
                  sha512 = "09a68051504bb16069dd6af8901f2bbeadfd08ad5353d8bcc0c4784e814fb293d9197b4fb0a8393be1f2db003cd987a9e4b98391bbe18c50ae181dace20c2fa4";
                };
                AppleSkin = fetchurl {
                  url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/VfjnbBAT/appleskin-fabric-mc1.21.5-3.0.6.jar";
                  sha512 = "36a0849b0483066abd74fc504eb0b7bded24ed7a2713ac8b005dd90b2c3c8c062101737aa9dd0173f692e16e504787fbd48214dbc94a2572969c33d4fa3cf3df";
                };
                Krypton = fetchurl {
                  url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar";
                  sha512 = "2e2304b1b17ecf95783aee92e26e54c9bfad325c7dfcd14deebf9891266eb2933db00ff77885caa083faa96f09c551eb56f93cf73b357789cb31edad4939ffeb";
                };
                Moonrise = fetchurl {
                  url = "https://cdn.modrinth.com/data/KOHu7RCS/versions/HA6FKQbq/Moonrise-Fabric-0.3.0-beta.1%2Bb641035.jar";
                  sha512 = "856df809fe0a83a226e612613598c207d014a785f1dbbd657abb5e0231cc6f8081135fe9b7e08a3c2ef5fb10378816d8c1c7e8a694fa3483cc6c91acf1ee1332";
                };
                Noisium = fetchurl {
                  url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/sUh67T4Y/noisium-fabric-2.6.0%2Bmc1.21.5.jar";
                  sha512 = "4471b6137de7e2109987df8fe62ac836741e68ba3c57303a0f2dc362c0ab8e7aca656d28046e250362316c1144396132a5531dfb12b5a664c68eb294991af938";
                };
                DistantHorizon = fetchurl {
                  url = "https://cdn.modrinth.com/data/uCdwusMi/versions/Mt9bDAs6/DistantHorizons-neoforge-fabric-2.3.2-b-1.21.5.jar";
                  sha512 = "e17d845f5ddb71a9ca644875a02b845e045bb5c7e72429e120271636936a816b416bb4ba13789de18c3af6a1a5f5b7ed5dbe07326c60d5c49534a382310dab1f";
                };
                NetherPortalFix = fetchurl {
                  url = "https://cdn.modrinth.com/data/nPZr02ET/versions/3xwbxqcv/netherportalfix-fabric-1.21.5-21.5.1.jar";
                  sha512 = "267ed5768d1a232bad907cbd5b1f226309ad1953f7267b6308c3172cad842bb5ab51d34c4530b373ab24c54e3d97a9cba33832eac1bf9fa3cf362bfd754ae7c3";
                };
                DungeonsAndTaverns = fetchurl {
                  url = "https://cdn.modrinth.com/data/tpehi7ww/versions/xuwRmYo8/dungeons-and-taverns-v4.7.jar";
                  sha512 = "048f097bcf62ee99c601f99611c0b1c7d954fd01b0dd1a73224ad25404230aff6f02bae9b235bce7ac881adaa0719661bc659601b777310d0fbd1d6270f59882";
                };
                BannerFlags = fetchurl {
                  url = "https://cdn.modrinth.com/data/cCStmVIN/versions/1Bj3xcYf/banner-flags-2.9.jar";
                  sha512 = "fa3b35ce0fc0988c4b8044568b570b0ad64b0943945d25ff4127859717cdef6347e6ad95d902b52685ba4119846045c2f083ef5534338d823309f9244777c07b";
                };
                Terralith = fetchurl {
                  url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/vGKEdR1w/Terralith_1.21.x_v2.5.9.jar";
                  sha512 = "7adb34180c6f7f4984b500577f74d2602adc551da6f0f5fdfd4c20fc383560312121277bb6ff6acedf30d294af65cba13a1d28326b1d9575253ea7c5b5eaf895";
                };
                SpawnAnimations = fetchurl {
                  url = "https://cdn.modrinth.com/data/zrzYrlm0/versions/YW1ZN5zl/spawnanimations-v1.10.1-mc1.17-1.21.5-mod.jar";
                  sha512 = "be2c1edc675d18f77ce69b7cd8291e8c8f682362074c6b4fee63fe02c6d4d39cfde9b18ab61dcd4fe6fab3901c67da833d0efb11d77cbf593d1b5151dc9bf31c";
                };
                StructoryTowers = fetchurl {
                  url = "https://cdn.modrinth.com/data/j3FONRYr/versions/oteEZjc2/Structory_Towers_1.21.x_v1.0.11.jar";
                  sha512 = "e72823a2e6c66898a8834098c8e50d3f2c176005d6955682f1b9f5005030b268419796f58ed687b1511038cee5b178cc379a77e604073c6b55f82c4ed1310012";
                };
              }
            );
        };
      };
    };
  };
}
