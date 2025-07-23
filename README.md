
# HydroField App

HydroField is a cross-platform field data collection tool for anyone in hydrographic industry. It supports offline-first workflows and will integrate photos, survey data, GPS, RTK, LiDAR, and barcode-based sample tracking into a unified mobile and web-based system.

## Features

- 📷 Capture geo-tagged, compass-oriented photos with timestamp and notes
- 📐 Record stream cross-section survey points (chainage, elevation, angle, RL)
- 🧪 Log water sample data with barcode scan and generate CoC CSV files
- 🌞 Visualize sun position in 3D with live orientation tracking
- 🛰️ Integrate with external RTK GNSS for precision data (future)
- 🗺️ Capture LiDAR scans of gauging sites (iOS Pro only)
- ☁️ Sync data to cloud (Supabase backend)
- 🧾 Web dashboard for full data review and editing (planned)
- 🔒 Secure and scalable backend with SSO support

## Tech Stack

- **Flutter**: Cross-platform frontend (iOS, Android, Web)
- **SQLite (Drift)**: Offline data storage
- **Supabase**: Backend (PostgreSQL, Auth, Storage)
- **Markdown Spec**: See [hydrofield_spec.md](./specs/hydrofield_spec.md)

## Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/your-org/hydrofield.git
   cd hydrofield
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run main.dart
   ```

## Folder Structure

```
main.dart        # Application entry point
models/          # Data models
screens/         # UI screens
services/        # Sync, storage, sensors
specs/
  hydrofield_spec.md
```

## License

MIT License © 2025 Cameron Domotor
