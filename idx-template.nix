{ pkgs, project_name ? "my_flutter_app", include_firebase ? false, theme_color ? "blue", include_state_management ? "none", ... }:

let
  # Define theme colors mapping
  themeColors = {
    blue = "Colors.blue";
    purple = "Colors.deepPurple"; 
    green = "Colors.green";
    orange = "Colors.orange";
    red = "Colors.red";
  };
  
  selectedColor = themeColors.${theme_color} or "Colors.blue";
  
  # Define state management dependencies
  stateManagementDeps = {
    provider = "flutter pub add provider";
    riverpod = "flutter pub add flutter_riverpod";
    bloc = "flutter pub add flutter_bloc";
    none = "";
  };
  
  selectedStateManagement = stateManagementDeps.${include_state_management} or "";
  
in {
  packages = [
    pkgs.flutter
    pkgs.git
    pkgs.curl
    pkgs.unzip
  ];

  bootstrap = ''
    echo "Creating Flutter project: ${project_name}"
    mkdir -p "$out"
    
    # Create Flutter project
    cd "$out"
    flutter create "${project_name}" --project-name="${project_name}"
    cd "${project_name}"
    
    # Add Firebase dependencies if requested
    ${if include_firebase then ''
      echo "Adding Firebase dependencies..."
      flutter pub add firebase_core firebase_auth cloud_firestore
    '' else ""}
    
    # Add state management dependencies if requested
    ${if include_state_management != "none" then ''
      echo "Adding ${include_state_management} state management..."
      ${selectedStateManagement}
    '' else ""}
    
    # Copy template files and customize them
    cp -r ${./.} ./template_source
    
    # Update main.dart with selected theme color
    cat > lib/main.dart << 'EOF'
import 'package:flutter/material.dart';
${if include_firebase then "import 'package:firebase_core/firebase_core.dart';" else ""}

${if include_firebase then ''
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
'' else ''
void main() {
  runApp(const MyApp());
}
''}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${project_name}',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ${selectedColor}),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '${project_name} Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ${if include_firebase then ''
            const SizedBox(height: 20),
            const Text(
              'Firebase is configured and ready to use!',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            '' else ""}
            ${if include_state_management != "none" then ''
            const SizedBox(height: 20),
            Text(
              '${include_state_management} state management is ready!',
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
            '' else ""}
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
    
    # Update pubspec.yaml with correct project name
    sed -i.bak "s/name: template/name: ${project_name}/" pubspec.yaml
    sed -i.bak "s/description: \"A new Flutter project.\"/description: \"${project_name} - A Flutter application created from template\"/" pubspec.yaml
    rm pubspec.yaml.bak
    
    # Clean up template source
    rm -rf template_source
    
    # Make sure everything is writable
    chmod -R +w "$out"
    
    echo "Flutter project '${project_name}' created successfully!"
    echo "Theme color: ${theme_color}"
    echo "Firebase included: ${toString include_firebase}"
    echo "State management: ${include_state_management}"
  '';
}
