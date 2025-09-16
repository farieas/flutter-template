{ pkgs, ... }:
{
  channel = "stable-24.05";
  packages = [
    pkgs.flutter
    pkgs.git
    pkgs.androidsdk
    # etc
  ];
  services = {};
  idx = {
    workspace = {
      onCreate = {
        default.openFiles = [
          "lib/main.dart"
          "pubspec.yaml"
        ];
      };
    };
  };
}
