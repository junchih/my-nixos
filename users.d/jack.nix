module-args:

with builtins;

let

  modulesPath = module-args.modulesPath;
  pkgs = module-args.pkgs;
  configuration = module-args.configuration;
  has-xserver = configuration.services.xserver.enable;

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

    ] ++ (if has-xserver then
    with pkgs; [

      alacritty tor-browser-bundle-bin

    ]
    else
    []);

    hashedPassword = "$6$tuw/Fyhe6sY$8v4nfQ/1Cj.JNB8POt/N9ozwMdKt3RSCB7yOFfnbBAWw0Erhl5YoWHOM0W0Jy0HvtjCN.rTfJnVf7geEz/2UX0";

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWxW3lz6KBoHGmJ52CtN7hSMy6fZ/8ebu4qCGwfHhuQ/D9XoOHZNrKmrczEdqCQ0PJoJeUPMYMnpFWRnrCP1MDD/XpeUl74mwyP1g7gBUurxaqgsRaCOCpWC6XowRUpYlVULbsFLYU1YwuJbf4uU1loSdmY0oNQ6BYwkACr3nloJwvLUI96x3nECsg9e9dTH8xC1s4ywUB4Ep+Bvj+jrouD8Qe4EtCm4Yl/9pKqeuviWrdtwJM+ZuSvWJi4fd8CJ+F1Wa9eY8TMCq9K3jsp46juCTLaJhDoOAnUPLo01J8n9B+3qavvu3E0kYNmBbFHEKG1741Q43GsEjMsF0/iO0X jack@lbpro"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzniwuBAqRn2dkNmBdH7eYx2JJBX8SZCSU/8MshZJOvWDHVs7eads78MA41tCgN4zgUXkiwjrHP2MtvLpsxeNMmMY1s4BFFzA7mLce4u0g7n6HAnwU1EV8gbP4Vh+Kys1WQKU0bnchG2gJYCcPENV42G87RFJNybFM2bZJRDMjwhcH8DZUbhfUWMKAIkFQCUrR1PLQMNKPme01QcHEv2RDH4VXU56cc/2UqsPujIdQwcIZfl3RK/7nVDJ9JAo8fftKALhq+rRL1bUCNNYC8grhAL3ffk4kj4BurAL1tVo3hz1DagRdJG+zdkVh2qstlpGJSszS7ouA/5HSelv9qTqJ jack@lbwin"
    ];
}
