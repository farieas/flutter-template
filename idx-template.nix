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
    
    echo "Creating Flutter project: $PROJECT_NAME"
    echo "State Management: $STATE_MANAGEMENT"

    # Create Flutter project
    flutter create "$out" --project-name="$PROJECT_NAME" --org="$ORG_NAME"

    # Create .idx directory
    mkdir "$out"/.idx

    # Copy dev.nix file to .idx directory
    cp ${./dev.nix} "$out"/.idx/dev.nix

    # Create structure
    # mkdir "$out"/lib/{screens,widgets,models,services}

    install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix

    # Add Dependencies
   

    chmod -R u+w "$out"

    echo ""
    echo "✅ Flutter template created successfully!"
    echo "📱 Project: $PROJECT_NAME"
    echo "🔄 State Management: $STATE_MANAGEMENT"
    echo ""
    echo "Ready to start coding with $STATE_MANAGEMENT!"
  '';
}
