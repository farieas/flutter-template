{ pkgs, ... }: {
  # Channel for packages
  channel = "stable-24.05";
  
  # Development packages
  packages = [
    pkgs.flutter
    pkgs.git
    pkgs.curl
    pkgs.unzip
    pkgs.androidenv.androidPkgs_9_0.platform-tools
    pkgs.jdk17
  ];
  
  # Environment variables
  env = {
    ANDROID_HOME = "${pkgs.androidenv.androidPkgs_9_0.androidsdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}";
  };
  
  # IDE configuration
  idx = {
    # Extensions to install
    extensions = [
      "Dart-Code.dart-code"
      "Dart-Code.flutter"
      "ms-vscode.vscode-json"
      "bradlc.vscode-tailwindcss"
      "esbenp.prettier-vscode"
    ];
    
    # Workspace configuration
    workspace = {
      # Files to open when workspace is created
      onCreate = {
        default.openFiles = [
          "lib/main.dart"
          "pubspec.yaml"
          "README.md"
        ];
      };
      
      # Preview configuration
      previews = {
        enable = true;
        previews = {
          web = {
            command = ["flutter", "run", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "$PORT"];
            manager = "flutter";
          };
        };
      };
    };
  };
  
  # Services (if needed)
  services = {
    # You can add services like databases here if needed
    # Example:
    # postgres.enable = true;
  };
}
