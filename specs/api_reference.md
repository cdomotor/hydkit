
# HydroField API Reference

## Supabase Tables

### stations
- `id`: UUID
- `code`: Text
- `name`: Text
- `gps_lat`, `gps_lon`, `elevation`: Float

### field_activity_sessions
- `id`: UUID
- `station_id`: FK
- `user_name`: String
- `start_time`, `end_time`: DateTime

### water_samples, stream_surveys, photo_captures, sun_track, lidar_scans
- `id`: UUID
- `field_activity_session_id`: FK
- `gps_lat`, `gps_lon`, `timestamp`
- `synced`: Bool

## Storage

- `photos/`
- `lidar/`
- `coc/`

## Auth

- SSO via Supabase Auth
- Row-level security enabled

## Edge Functions

- `/generate-coc`
- `/sync-logger`
