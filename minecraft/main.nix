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
        jvmOpts = "-Xmx8G -Xms8G -XX:+UnlockExperimentalVMOptions -XX:+UseZGC -XX:+ZGenerational -XX:+UseTransparentHugePages -XX:+UseLargePages -XX:+UseStringDeduplication -XX:+OptimizeStringConcat";

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
        };

        symlinks = {
          "config/polymer/auto-host.json" = pkgs.writeText "polymer-auto-host.json" (builtins.toJSON {
            "_c1" = "Enables Polymer's ResourcePack Auto Hosting";
            "enabled" = true;
            "_c2" = "Marks resource pack as required";
            "required" = false;
            "_c7" = "Mods may override the above setting and make the resource pack required, set this to false to disable that.";
            "mod_override" = true;
            "_c3" = "Type of resource pack provider. Default: 'polymer:automatic'";
            "type" = "polymer:automatic";
            "_c4" = "Configuration of type, see provider's source for more details";
            "settings" = {};
            "_c5" = "Message sent to clients before pack is loaded";
            "message" = "This server uses resource pack to enhance gameplay with custom textures and models. It might be unplayable without them.";
            "_c6" = "Disconnect message in case of failure";
            "disconnect_message" = "Couldn't apply server resourcepack!";
            "_c8" = "Allows to define more external resource packs. It's an object with 'id' for uuid, 'url' for the pack url and 'hash' for the SHA1 hash.";
            "external_resource_packs" = [];
            "_c9" = "Moves resource pack generation earlier when running on server. Might break some mods.";
            "setup_early" = false;
          });
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
                Polymer = fetchurl {
                  url = "https://cdn.modrinth.com/data/xGdtZczs/versions/dqiMdAQo/polymer-bundled-0.12.6%2B1.21.5.jar";
                  sha512 = "cb59aed83e899feac07a7d14dea635e5e28ed486f383c89fb59f778bbd7e481d016875004804e7a6c3c9e01e60929174708d40dce8a30bd69093c24fa9d837a1";
                };
                PolyDecoration = fetchurl {
                  url = "https://cdn.modrinth.com/data/5710VC7f/versions/aOahWdc9/polydecorations-0.7.4%2B1.21.5.jar";
                  sha512 = "c34b6e83e3a0600c7dcbe13f6872f883360c10f677b4145e50c85f472c1ed9dd22bc615f3680257f9b822e27565266d95f0aae63d2f338e7a7eb3d755d1baf6c";
                };
                PolySit = fetchurl {
                  url = "https://cdn.modrinth.com/data/G9eJHDO2/versions/RxruJi0u/polysit-0.9.5%2Bmc.1.21.5.jar";
                  sha512 = "9e628a0a0097576bfa0572021a0449124bb45214892948255b35b4d45bacdf0861a5828289347606d95b97d314e7cf534fa39c10a2f744dbea3f6cdd529e0679";
                };
                PolyChess = fetchurl {
                  url = "https://cdn.modrinth.com/data/n4KHrvqn/versions/H16NA3Dm/polychess-1.21.5-0.1.jar";
                  sha512 = "9dc6cf51e5e9b94247ec95c280503a4e38e9364ca9e1b6b98b404b994bce3727c2022a1510da3a25677efd2ea7b959b00ce4adaab3eac7c7725b8364f4ba0651";
                };
                PolyTrinkets = fetchurl {
                  url = "https://cdn.modrinth.com/data/G8hlgtEk/versions/85PakGw6/trinkets-3.11.0-beta.1%2Bpolymerport.1.jar";
                  sha512 = "21ffc1d1c966c8b70f0e7702cac4562042855f161b09b2c2b636c5d7e23364da5603ea7af0923a03d7f1b1db976eea0c7a8b8b3d4cc0cff1ed39068efef03774";
                };
                MoreTools = fetchurl {
                  url = "https://cdn.modrinth.com/data/S6P4vaGq/versions/jX9kRAFI/moretools-1.8.2%2B1.21.5.jar";
                  sha512 = "03ab1f50860d15977b3373644b3fd170d558593415bf7857b57b14403a0cb95b1020541496f47de2cae667917c47a99409537433f6991446609d7f2300b7b44a";
                };
                MoreFurnaces = fetchurl {
                  url = "https://cdn.modrinth.com/data/l5c3cXjI/versions/pXLsrSm0/morefurnaces-1.2.0%2B1.21.5.jar";
                  sha512 = "aabd976e534fbc835f2e585c5ca45b75aa194675f177d7f0c60eb2002f2dccf531fd39f895bc76fd4c67f4d3d5acc73fd7a3ee16662a1c074ee2722592542a15";
                };
                Spiders2_0 = fetchurl {
                  url = "https://cdn.modrinth.com/data/pHIx2aDH/versions/ERWlEdKL/spiderstpo-1.0.0.jar";
                  sha512 = "0093d97a084480cb84430214ff0c572da5dc871bf505f72a298ea0964fa7c80b35ccf03ed6e01adda36b7c231a6f73901faba9c9b72531a9450894f2b1d21617";
                };
                ArmorStandEditor = fetchurl {
                  url = "https://cdn.modrinth.com/data/Ef9ZREBZ/versions/62aDXxe8/armor-stand-editor-2.8.0%2B1.21.5-rc1.jar";
                  sha512 = "400373c7a5349eaeff3681ce721a9097f924b69f25716fc370bd3d5f9e5643e615f274f4e7e9e5ddd88a7de3e70164ce174f9da4d76a6caff0834f6d4b74c170";
                };
                ServerBackpacks = fetchurl {
                  url = "https://cdn.modrinth.com/data/E7IsBILg/versions/Np2h5oLp/serverbackpacks-1.3%2B1.21.5.jar";
                  sha512 = "cb0352cd7a3603ad9b6da4deeef7e2d2aeb14063d4d2941fe4e65456398c0b5178b16d38eb2be071f4dd18320c5f895a6a19ab0e0e5f869aec04598ad734da2f";
                };
                Televator = fetchurl {
                  url = "https://cdn.modrinth.com/data/9kdDMOvM/versions/Nck9ihns/televator-1.2.4.jar";
                  sha512 = "85095585efbf2401fa24f9349e37dc7e428a107567c9f572bb31e2235fe23880d03920bd2ce04dca15215a59278cf158d1c33d5828146402089d4cf772e799ab";
                };
                GoneFishing = fetchurl {
                  url = "https://cdn.modrinth.com/data/EAw8Gldo/versions/CEr25sSE/go-fish-1.7.2%2B1.21.5.jar";
                  sha512 = "e425316b2573360b55a011605c82006ab5bec952125d81551da184395b7dd4cbe4f24616de4ea1017e57f7241e2634d9b020ee9aab6376c1feb46b496ca7468d";
                };
                Filament = fetchurl {
                  url = "https://cdn.modrinth.com/data/yANxwqSX/versions/LcoxSXn4/filament-0.17.6%2B1.21.5.jar";
                  sha512 = "ab344afc029520d9f54d58968ca2f169c957aba13f0f0e0eab0469a338e1ea2cdd51ff8957d666cc29027fb907a7ea3174b9508e43b593469be5b0f3bcd291b7";
                };
                TomsAdditionsDecoAndFurnitures = fetchurl {
                  url = "https://cdn.modrinth.com/data/DLsxkJLC/versions/DILLXbPo/tsa-decorations-2.1.6%2B1.21.5.jar";
                  sha512 = "e024a31764825d4e42cde34967749c29baedf1e9717040f9e660a8a2ccbeb09389e7c0361e94ffa1c47cd30726cee857c9a9759ae04680e0823c00ac26516182";
                };
                TomsAdditionsStones = fetchurl {
                  url = "https://cdn.modrinth.com/data/iLZabwvA/versions/K7Ji5g4r/tsa-stone-1.1.5.jar";
                  sha512 = "b7cff1efd3683c102f0a29f6ba2497da9f7993874f6533e7de5423c4f91bb2c8a966dc7330ca36519ac4110fd910e503c6f25eb5f47f86b9d64246f4506b094e";
                };
                TomsAdditionsPlanks = fetchurl {
                  url = "https://cdn.modrinth.com/data/SU4YwX00/versions/vYmZLUa0/tsa-planks-1.1.2%2B1.21.2-rc1.jar";
                  sha512 = "ea4aa0921aeb424dae494f9112867e46ac0d1b356c638760f60680bca816e18ac7bc6c41f511fd55535b3c179b4024d3a9366ad8e5522373c23a6e3893a33fa7";
                };
                TomsAdditionsConcrete = fetchurl {
                  url = "https://cdn.modrinth.com/data/MXH6I6VI/versions/HT4hFud3/tsa-concrete-1.1.1%2B1.21.2-rc1-1.21.2-rc1.jar";
                  sha512 = "4ac25322d27bd01439d9e81c348ba679eb2a89a3e8c383348047766f97570bd610e6059912cd8b2a30689656c41d619475fe878d846099f0f11737560abf35ec";
                };
                TomsAdditionsMobs = fetchurl {
                  url = "https://cdn.modrinth.com/data/PXaH6GuW/versions/ZGmVKBZ9/toms_mobs-2.2.8%2B1.21.5.jar";
                  sha512 = "39abfc1e2ccff4bb699c797fdd8ca23dd24aca476f7cef8429bc872c8f2328a0ffb13b8c6904e194ada2d9dc1832d20800349d35a67ceedb6df2a57e440e8d8f";
                };
                RightClickHarvest = fetchurl {
                  url = "https://cdn.modrinth.com/data/Cnejf5xM/versions/9jOYB5rp/rightclickharvest-fabric-4.5.3%2B1.21.5.jar";
                  sha512 = "19fd140057be549d252de5cc20f0dec855e6aeb048d90a4f4741eb615245fed805a8a7f372655f81d0b06283c83c89c1ba8de04ee5339b5735bf53b27751b65f";
                };
                DoubleDoor = fetchurl {
                  url = "https://cdn.modrinth.com/data/JrvR9OHr/versions/1gYbfoqD/doubledoors-1.21.5-7.0.jar";
                  sha512 = "1640722969e1d6ed9474cb968381359ee9e7a61509a730f4c2cf75d84069fe3afe7ef2d306459a0597f4453dac22dd2d4414ec618642600cddeeb263f8b98d88";
                };
                UniversalGraves = fetchurl {
                  url = "https://cdn.modrinth.com/data/yn9u3ypm/versions/ejJjBZIM/graves-3.7.1%2B1.21.5.jar";
                  sha512 = "2852ccf4ea276e48508af3e5c61dd8c010598ee158e05cfb7f9f6548c2e3915e6c7e4ae5450ebec71c4e7e28ef3f669e2f21eea9931d897f1b4ef2b41e4d9e29";
                };
                BoruvkaFood = fetchurl {
                  url = "https://cdn.modrinth.com/data/l4Fz32NE/versions/O7MvWl5K/borukva-food-0.1.12%2B1.21.5.jar";
                  sha512 = "4b2bfcf478fa8285cea5adf27a806b518b3236f3ae62e2c278027b7fa332e56fe4dd047fba9696797cf67f878fde52dfb61a2fdf0dc19debedd4b74bb2a9245c";
                };
                BoruvkaFoodExotic = fetchurl {
                  url = "https://cdn.modrinth.com/data/odwLjifj/versions/Yh63f5Yo/borukva-food-exotic-3.8.jar";
                  sha512 = "2d2deee173741033d75751aa3ba96f5b12939eabc0e71c7391df9b202c0d2a81d2dc808941e7feceda36755bb628f565c0d3e94d14dfd20c036e47a2f160c4e7";
                };
                Brewery = fetchurl {
                  url = "https://cdn.modrinth.com/data/nr7cSJlY/versions/XFrtRxXM/brewery-0.11.1%2B1.21.5.jar";
                  sha512 = "c3a96616076f7e1b7b09b1ef8df79e9f2a140e7e49772e6b9063da361e270df708d06a8558232cb389a51e9ebdefb90867d6f2f47bf5a1ac42e12f1b8de7455a";
                };
                SleepWarp = fetchurl {
                  url = "https://cdn.modrinth.com/data/DlSXkZVT/versions/vnRGqK0o/sleepwarp-2.7.0%2B1.21.5.jar";
                  sha512 = "905b2aaf51ddff2f0d87bdd9c854ee5b936da1e0d242e7bfbb6e944e54a10e9779a6c979a21d88a20187f891ee54900b5f63862d36629d492e0ea0053b87967f";
                };
                Ouch = fetchurl {
                  url = "https://cdn.modrinth.com/data/nbxqFJCy/versions/VbLrL1Ak/ouch-1.4.0%2B1.21.5.jar";
                  sha512 = "314fa99c73806def9b06eaf3c4da86e4434dd4888ba67a7184b1bc04a462f6a56c59b63dd83d7f15a84ab07f021cc62e2eaa0b95d41534a65dbd950739fe0df4";
                };
                Danse = fetchurl {
                  url = "https://cdn.modrinth.com/data/vSdZ5THv/versions/tIqr323C/danse-2.1.3%2B1.21.5.jar";
                  sha512 = "699313d223002f5ee953f7ff699fd19e5aea1b65061359e1f3f94e7de1176e3447aceedfe19cb000d6d54e838e86a7c3976e223d66e347acda44caf2b5552903";
                };
                Collective = fetchurl {
                  url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/aCWSF57s/collective-1.21.5-8.3.jar";
                  sha512 = "bf47502d20e03c2fd5964e4799d7988334358ffe26cbb9b9414d453d771a19938e13dcc0989f5b1c0c5e965f35a9f480c95cf0849818c6433f470771c4c5229e";
                };
                ArchitecturyAPI = fetchurl {
                  url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/ImZUcNzP/architectury-16.1.4-fabric.jar";
                  sha512 = "2edf94af0b6fc9e72e91b4a094e7168b4c2fedbdc0c0713b01d817e4294e297a75fdd8cd89e6e50a9a559d7bf0ad75fcb93d35e1b0beb62c9d1d814f94b53cdf";
                };
                Balm = fetchurl {
                  url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/KHiNGdha/balm-fabric-1.21.5-21.5.17.jar";
                  sha512 = "91cad77f3be459e7d04941546a3b79f5cad09bad8cd54660c939665db6a441ceaa1be2a3500c5e89415cc9ea57719655aaa61c820731bac6234074e3ac2fda0d";
                };
                JamLib = fetchurl {
                  url = "https://cdn.modrinth.com/data/IYY9Siz8/versions/MrRqh8ql/jamlib-fabric-1.3.5%2B1.21.5.jar";
                  sha512 = "74536d9f7eefa43d22d9737153548003c2b1d9dbbb9180490162336f3b68b273104f77241680f7f9a32808577abd87cbd2c53d3ea4a011ab6f928b3cb53acdd6";
                };
              }
            );
        };
      };
    };

    # Use systemd-tmpfiles for proper directory management
    systemd.tmpfiles.rules = [
      # Create /run/minecraft directory with proper ownership
      "d /run/minecraft 0755 minecraft minecraft -"
      # Set ownership for any sockets created in the directory
      "Z /run/minecraft 0755 minecraft minecraft -"
    ];
  };
}
