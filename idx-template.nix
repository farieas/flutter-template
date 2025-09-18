{ pkgs, projectName, orgName, stateManagement, ... }: {
  packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.flutter
        pkgs.dart
    ];
  bootstrap = ''
    # Get template parameters
    PROJECT_NAME="${projectName}"
    ORG_NAME="${orgName}"
    STATE_MANAGEMENT="${stateManagement}"
    echo "out: $out"
    echo "Creating Flutter project: $PROJECT_NAME"
    echo "State Management: $STATE_MANAGEMENT"

    # Create Flutter project
    flutter create "$out"
    mkdir "$out"/.idx

    # Create basic directory structure
    mkdir "$out"/lib/{screens,widgets,models,services}
    cp ${./dev.nix} "$out"/.idx/dev.nix
    install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix

       # Add Dependencies
    if [ "$STATE_MANAGEMENT" = "bloc" ]; then
      echo "Adding bloc..."
     # flutter pub add flutter_bloc
    else
      echo "No State is adding"
    fi

    chmod -R u+w "$out"

    echo ""
    echo "✅ Flutter template created successfully!"
    echo "📱 Project: $PROJECT_NAME"
    echo "🔄 State Management: $STATE_MANAGEMENT"
    echo ""
    echo "Ready to start coding with $STATE_MANAGEMENT!"
  '';
}
