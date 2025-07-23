#!/bin/bash

echo "🛠️ Installing Flutter & dependencies..."

# 1. Install basic dependencies
sudo apt update && sudo apt install -y \
    curl git unzip xz-utils zip libglu1-mesa libgtk-3-dev \
    openjdk-11-jdk clang cmake ninja-build pkg-config libgtk-3-dev

# 2. Install Flutter SDK
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.9-stable.tar.xz
tar xf flutter_linux_3.13.9-stable.tar.xz
export PATH="$PWD/flutter/bin:$PATH"

# 3. Enable Flutter & accept licenses
flutter config --no-analytics
yes | flutter doctor --android-licenses
flutter doctor

# 4. Install Flutter project dependencies
cd /workspace/hydkit
flutter pub get

# 5. Optional: run tests or build the app
# flutter test
# flutter build web

echo "✅ Flutter is ready."