{ pkgs, include_firestore ? true, auth_type ? "email", ... }:
{
  packages = [
    pkgs.flutter
    pkgs.git
  ];

  bootstrap = ''
    mkdir -p "$out"
    # scaffold flutter project
    flutter create "$out/my_app"
    
    # navigate
    cd "$out/my_app"
    
    # Add firebase packages
    flutter pub add firebase_core firebase_auth
    ${ if include_firestore then "flutter pub add cloud_firestore" else "" }
    
    # Optionally scaffold Google Sign-In if auth_type == "google"
    ${ if auth_type == "google" then
         "flutter pub add google_sign_in; # plus setup code"
       else
         ""
    }

    # Copy template files if you have any
    cp -R ${./starter_files} "$out/my_app/lib/"

    chmod -R +w "$out"
  '';
}
