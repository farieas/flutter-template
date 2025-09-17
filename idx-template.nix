{ pkgs, ... }: {
  bootstrap = ''
    # Get template parameters
    PROJECT_NAME="$${projectName:-flutter_app}"
    ORG_NAME="$${orgName:-com.example}"
    STATE_MANAGEMENT="$${stateManagement:-provider}"

    echo "Creating Flutter project: $PROJECT_NAME"
    echo "State Management: $STATE_MANAGEMENT"

    # Create Flutter project
    flutter create --org "$ORG_NAME" --project-name "$PROJECT_NAME" .

    # Create basic directory structure
    mkdir -p lib/{screens,widgets,models,services}

    # Update pubspec.yaml with state management dependencies
    cat > pubspec.yaml << EOF
name: $PROJECT_NAME
description: A Flutter application with $STATE_MANAGEMENT state management.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
EOF

    # Add state management specific dependencies
    case "$STATE_MANAGEMENT" in
      "provider")
        echo "  provider: ^6.1.2" >> pubspec.yaml
        ;;
      "bloc")
        echo "  flutter_bloc: ^8.1.6" >> pubspec.yaml
        echo "  bloc: ^8.1.4" >> pubspec.yaml
        ;;
      "riverpod")
        echo "  flutter_riverpod: ^2.5.1" >> pubspec.yaml
        echo "  riverpod_annotation: ^2.3.5" >> pubspec.yaml
        ;;
      "getx")
        echo "  get: ^4.6.6" >> pubspec.yaml
        ;;
    esac

    # Add dev dependencies
    cat >> pubspec.yaml << EOF

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
EOF

    # Add build_runner for riverpod code generation
    if [ "$STATE_MANAGEMENT" = "riverpod" ]; then
      echo "  build_runner: ^2.4.13" >> pubspec.yaml
    fi

    # Add flutter section
    cat >> pubspec.yaml << EOF

flutter:
  uses-material-design: true
EOF

    # Create main.dart with state management setup
    cat > lib/main.dart << EOF
import 'package:flutter/material.dart';
EOF

    # Add state management imports
    case "$STATE_MANAGEMENT" in
      "provider")
        echo "import 'package:provider/provider.dart';" >> lib/main.dart
        ;;
      "bloc")
        echo "import 'package:flutter_bloc/flutter_bloc.dart';" >> lib/main.dart
        ;;
      "riverpod")
        echo "import 'package:flutter_riverpod/flutter_riverpod.dart';" >> lib/main.dart
        ;;
      "getx")
        echo "import 'package:get/get.dart';" >> lib/main.dart
        ;;
    esac

    # Add main function
    cat >> lib/main.dart << EOF

void main() {
EOF

    case "$STATE_MANAGEMENT" in
      "riverpod")
        echo "  runApp(const ProviderScope(child: MyApp()));" >> lib/main.dart
        ;;
      *)
        echo "  runApp(const MyApp());" >> lib/main.dart
        ;;
    esac

    echo "}" >> lib/main.dart

    # Add MyApp class
    cat >> lib/main.dart << EOF

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
EOF

    case "$STATE_MANAGEMENT" in
      "getx")
        cat >> lib/main.dart << EOF
    return GetMaterialApp(
      title: '$PROJECT_NAME',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
EOF
        ;;
      *)
        cat >> lib/main.dart << EOF
    return MaterialApp(
      title: '$PROJECT_NAME',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
EOF
        ;;
    esac

    cat >> lib/main.dart << EOF
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('$PROJECT_NAME'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'State Management: $STATE_MANAGEMENT',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Counter Value:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
EOF

    # Install dependencies
    flutter pub get

    echo ""
    echo "✅ Flutter template created successfully!"
    echo "📱 Project: $PROJECT_NAME"
    echo "🔄 State Management: $STATE_MANAGEMENT"
    echo ""
    echo "Ready to start coding with $STATE_MANAGEMENT!"
  '';
}