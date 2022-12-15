{ configuration, lib, pkgs, ...}:
let

  has-xserver = configuration.services.xserver.enable or false;

in

  {
    description = "Jack Mao";
    isNormalUser = true;
    createHome = true;
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [

      # normal life
      wget curl croc tree dnsutils ncdu
      unzip unrar gnutar
      ffmpeg yt-dlp

      # development environment
      direnv git ctags gnumake binutils linuxPackages.perf
      python3 black deno stylua

    ] ++ (if has-xserver then [

      fira-code hanazono
      alacritty
      tor-browser-bundle-bin

    ] else []);

    hashedPassword = "$6$tuw/Fyhe6sY$8v4nfQ/1Cj.JNB8POt/N9ozwMdKt3RSCB7yOFfnbBAWw0Erhl5YoWHOM0W0Jy0HvtjCN.rTfJnVf7geEz/2UX0";

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWxW3lz6KBoHGmJ52CtN7hSMy6fZ/8ebu4qCGwfHhuQ/D9XoOHZNrKmrczEdqCQ0PJoJeUPMYMnpFWRnrCP1MDD/XpeUl74mwyP1g7gBUurxaqgsRaCOCpWC6XowRUpYlVULbsFLYU1YwuJbf4uU1loSdmY0oNQ6BYwkACr3nloJwvLUI96x3nECsg9e9dTH8xC1s4ywUB4Ep+Bvj+jrouD8Qe4EtCm4Yl/9pKqeuviWrdtwJM+ZuSvWJi4fd8CJ+F1Wa9eY8TMCq9K3jsp46juCTLaJhDoOAnUPLo01J8n9B+3qavvu3E0kYNmBbFHEKG1741Q43GsEjMsF0/iO0X jack@lbpro"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDROWnA6+0kIYhrjl24/vnoZWnisimVktNHDAJud9SbbPuEGRbrZv2ljBG8TRwoCFz+Dfd3TPmS7vSsBZEcleJo4RGaPjMvtEFpCTR0IWVIIJ06DneHMgnDT+tI0oUH0lvJPOVdWyV8HG/s0zTfY35BiW++JomiNLGrvWNnqDOe5uYsVGqxvi2lO24BXvvac2TGe/triWpDlrkcqEGE4Tp+/RqYd3/1t5PnW592vQ/nhQhDWu/WbWGY0r6MOU945gRiw4BMOud3Elp9Kr2cKReGNdxz84Ni3W4mMI6s3WcvlKVbtM5FFqql9EpPJo+WEa+5rr+uERZBmqAh95kbpaZo82PTW5wN9bqfrpwLkhaqiY3oC7A86tKtizMHLcGOJMR1pRdXjGZOZWpVbD/BDNlsMIUbj3XtpaDX0SV/VTrMHX6/SJGJETk6ARWTVLnRjTnSpY8XZkpb8MPk6ye2HswCatDV2FAeRDzo7itkPAiOy4I0PfTyyq6QY6AvCZSh4Wk= jack@lbnuc"
    ];
  }
