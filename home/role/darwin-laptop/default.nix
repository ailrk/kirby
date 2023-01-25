{ config, lib, pkgs, ... }:
with
lib;
let
  cfg = config.kirby.home.role.darwin-laptop;
in
{

  imports = [
    # DE
    ./de/skhd/default.nix
    ./de/yabai/default.nix
  ];

  options.kirby.home.role.darwin-laptop = {
    enable = mkEnableOption "Enable mac role";
  };

  config = mkIf (config.kirby.role == "darwin-laptop") {

    kirby.home.program = {
      git = {
        enable = true;
        userEmail = "jimmy123good@gmail.com";
        userName = "ailrk";
        signByDefault = true;
        gpgKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLbFS8ALmrL6ZyaAa4pqN3xZ4A8etGWhqwWxcoGYJSk0KzWo9v5yUWvBWhTxCbdMRvBCxjWUepZhSX1tBhBvM8wXJtO87aTUuo4aKz/cHkfAjEpdGQTw9mVUb3ZOldqzf9Wtks3+FRyS3+JcNlXgj72ItQVBN9swpCAfDtBawRLLcO4Nep38E4vXD6E5PaGL3ZsMaXsnX53w7imwv7NURNyuFtZKFYvYjulCBwrkOum3BOfYHh+dNTzEhRsP98yoClEuOqASGqIP2UB2t3X6K/5RVtTNAmeLMvaES2WD2cz65MRtr5vO+eb71qvaDf+WGKXO8cLwyjTEJu96f4qmNfFTcSREj9quDAN0kUIvHuVKRuldQvIuWFLDuqoXw4C+lHFWLeuZbk9MTxP+S7fzngCrKeJBctSeBP2tCedP5UpEReAa9eoW558eyivFHaux86lTT9ou1zgoLweltMpMsZu1nwjh3M+q2xxHQWpIiOMmV5TBo1wlCVsyJy+ZbpwFM= ailrk@ailrks-MacBook-Air.local";
      };

      scripts.enable = true;
    };


    nixpkgs.config = {
      allowUnfree = true;
    }

    home.packages = with pkgs; [
      xclip
      pinentry
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "kitty";
    };

  };
}
