{ pkgs, projectName, orgName, stateManagement, ... }: {

packages = [
  pkgs.flutter
  pkgs.git
  pkgs.curl
];

  bootstrap = ''
    # Get template parameters
    PROJECT_NAME=projectName
    ORG_NAME=orgName
    STATE_MANAGEMENT=stateManagement

    echo "Creating Flutter project: $PROJECT_NAME"
    echo "State Management: $STATE_MANAGEMENT"

    # Create Flutter project
    flutter create --org "$ORG_NAME" --project-name "$PROJECT_NAME" .

    # Create basic directory structure
    mkdir -p lib/{screens,widgets,models,services}

    echo ""
    echo "✅ Flutter template created successfully!"
    echo "📱 Project: $PROJECT_NAME"
    echo "🔄 State Management: $STATE_MANAGEMENT"
    echo ""
    echo "Ready to start coding with $STATE_MANAGEMENT!"
  '';
}
