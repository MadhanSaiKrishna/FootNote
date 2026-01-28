# Footnote Project Instructions

## Prerequisites
- Python 3.10+
- Flutter SDK (Latest Stable)
- Android Studio / Android Emulator

## 0. Environment Setup (One-time)
This project includes a local Flutter SDK. Add it to your path by running:
```bash
echo 'export PATH="$PATH:$HOME/footnote/flutter_sdk/bin"' >> ~/.bashrc
source ~/.bashrc
```

## 1. Backend Setup
1. Navigate to the project root.
2. Create virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r backend/requirements.txt
   ```
4. Run the server:
   ```bash
   uvicorn backend.app.main:app --host 0.0.0.0 --port 8000 --reload
   ```
   *Note: Using 0.0.0.0 is important for Android Emulator access.*

## 2. Frontend Setup
1. Navigate to `frontend/`:
   ```bash
   cd frontend
   ```
2. Get packages:
   ```bash
   flutter pub get
   ```
3. Run on Android Emulator:
   ```bash
   flutter run
   ```

## 3. Linux Desktop Setup (Ubuntu)
Since this project was generated in an environment without the Linux toolchain, you must enable it on your machine.

1. **Enable Linux Desktop**:
   ```bash
   flutter config --enable-linux-desktop
   ```
2. **Add Linux Support to Project**:
   ```bash
   cd frontend
   flutter create --platforms=linux .
   ```
3. **Run on Linux**:
   Ensure the backend is running (`uvicorn ...`). Then:
   ```bash
   flutter run -d linux
   ```

### Linux Notes
- **API URL**: The app automatically uses `http://localhost:8000` when running on Linux.
- **Window Sizing**: The UI is constrained to a maximum width of 800px to maintain readability on large screens.

## 4. Mock Data Mode
If the backend is not running or unreachable, click the **Bug Icon** in the top right of the app bar. This will toggle "Mock Data Mode" and display sample papers.

## Troubleshooting
- **API Connection Error**: Android Emulator uses `10.0.2.2` to access localhost. This is configured in `frontend/lib/services/api_service.dart`. If running on a physical device, change this to your computer's local IP address (e.g., `192.168.1.X`).
- **PDF Not Opening**: Ensure an app capable of opening PDFs is installed on the emulator/device.
