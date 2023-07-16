# namer_app
Simple Flutter web app. Allow to generate names, which consist of words pair.

Based on codelab: https://codelabs.developers.google.com/codelabs/flutter-codelab-first

Target platform - Linux. In order to be able to use "Hot reload".

## Build and release

### Linux
1. Run: flutter build linux --release
2. Project binaries are ready for release in namer_app/build/linux/x64/release/bundle/

To create deb package with use of "flutter_to_debian" package:
1. Run: flutter build linux --release
2. Install flutter_to_debian if not done yet: dart pub global activate flutter_to_debian
3. Run: flutter_to_debian

### Web
1. Run: flutter build web --release
2. Project files are ready for release in namer_app/build/web/
