{ pkgs, ... }:
{
  channel = "stable-24.05";
  packages = [
    pkgs.flutter
    pkgs.git
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
