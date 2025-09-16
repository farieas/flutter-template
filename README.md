# Flutter Template for Firebase Studio

This is a customizable Flutter template for Firebase Studio that allows you to quickly bootstrap Flutter projects with various configurations.

## Features

- ✅ **Customizable Project Name**: Choose your own project name
- ✅ **Optional Firebase Integration**: Add Firebase dependencies automatically
- ✅ **Theme Color Selection**: Choose from predefined color schemes
- ✅ **State Management Options**: Select from popular state management solutions
- ✅ **Development Environment**: Pre-configured with Flutter, Android tools, and VS Code extensions

## Template Parameters

When creating a new workspace with this template, you can customize:

### Project Name
- Set a custom name for your Flutter project
- Default: `my_flutter_app`

### Firebase Integration
- **Enabled**: Adds `firebase_core`, `firebase_auth`, and `cloud_firestore` dependencies
- **Disabled**: Creates a standard Flutter project
- Default: Disabled

### Theme Color
Choose from predefined Material Design colors:
- Blue (default)
- Purple
- Green  
- Orange
- Red

### State Management
Select your preferred state management solution:
- **None**: Use built-in `setState` (default)
- **Provider**: Adds `provider` package
- **Riverpod**: Adds `flutter_riverpod` package  
- **Bloc**: Adds `flutter_bloc` package

## How to Use This Template

### Option 1: Direct URL
Create a new workspace in Firebase Studio using this template:

```
https://idx.google.com/new?template=https://github.com/your-username/your-repo-name
```

### Option 2: Local Development
1. Clone this repository
2. Push to your own GitHub repository
3. Use the URL format above with your repository details

### Option 3: Add to Your README
Add an "Open in Firebase Studio" button to your project:

```markdown
[![Open in Firebase Studio](https://img.shields.io/badge/Open%20in-Firebase%20Studio-blue?logo=firebase)](https://idx.google.com/new?template=https://github.com/farieas/flutter-firebase-studio-template.git)
```


## What Gets Created

When you use this template, you'll get:

1. **Flutter Project Structure**: Complete Flutter project with proper organization
2. **Development Environment**: Pre-configured with Flutter SDK, Android tools, and Java
3. **VS Code Setup**: Flutter and Dart extensions automatically installed
4. **Customized Main App**: Your app will be configured with selected theme and features
5. **Dependencies**: Automatically adds selected packages (Firebase, state management)

## Template Files Structure

```
├── idx-template.json       # Template metadata and parameters
├── idx-template.nix        # Bootstrap script for project creation
├── .idx/
│   └── dev.nix            # Development environment configuration
├── lib/
│   └── main.dart          # Flutter app entry point
├── pubspec.yaml           # Flutter dependencies
└── README.md              # This file
```

## Development Environment

The template includes:

- **Flutter SDK**: Latest stable version
- **Android Development**: Platform tools and JDK 17
- **VS Code Extensions**: 
  - Dart Code
  - Flutter
  - JSON support
  - Prettier
- **Git**: Version control
- **Web Preview**: Automatically configured for Flutter web development

## Contributing

Feel free to fork this template and customize it for your specific needs. You can:

- Add more parameter options
- Include additional dependencies
- Modify the project structure
- Add custom scaffolding files

## License

This template is provided as-is for educational and development purposes.
