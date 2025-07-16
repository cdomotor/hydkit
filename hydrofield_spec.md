
# HydroField Data Collection App Specification

## Background

Hydrographic field workers collect spatial and time-sensitive data in rugged environments. This app consolidates manual, GPS, RTK, and sensor-based workflows into a unified mobile app with offline-first capability and cloud sync.

## Requirements

### Must Have
- Cross-platform (iOS, Android, Web)
- Offline storage and delayed sync
- Camera + GPS + compass + timestamp + notes
- Cross-section input (chainage, elevation, RL, angle, compass)
- Barcode-based water sampling + CoC CSV generation

### Should Have
- RTK integration
- Sky plot
- 3D sun path
- Cloud drive import/export
- LiDAR scanning (iOS Pro)
- SSO support

### Could Have
- Web dashboard
- Validation rules
- Annotated visual exports

## Architecture

- Flutter frontend
- SQLite local DB
- Supabase backend (PostgreSQL + Storage + Auth)

## Data Models

- Station
- FieldActivitySession
- WaterSample
- StreamSurvey
- PhotoCapture
- SunTrackCapture
- LiDARScan

## Sync Model

- Offline-first: device ➝ cloud sync
- Local `synced` flag, background queue
- Supabase Storage for media files
- Auth + RLS for secure data separation

## Logging

- `activity_log.txt` with timestamped actions
- Format: `[timestamp] ACTION | ID: context | Note: metadata`
