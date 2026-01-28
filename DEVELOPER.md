# Footnote Developer Guide

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
1. **Enable Linux Desktop**:
   ```bash
   flutter config --enable-linux-desktop
   ```
2. **Run on Linux**:
   Ensure the backend is running (`uvicorn ...`). Then:
   ```bash
   flutter run -d linux
   ```

### Linux Notes
- **API URL**: The app automatically uses `http://localhost:8000` when running on Linux.
- **Window Sizing**: The UI is constrained to a maximum width of 800px to maintain readability on large screens.

## 4. Execution Roadmap

| Category | Task | Status |
| :--- | :--- | :--- |
| **1. Project Basics** | Finalize project name & content scope | ✅ Done |
| | Fix Android package labeling | ✅ Done |
| **2. Backend** | **Add proper paper sources (arXiv API)** | ⬜ Pending |
| | **Fix Scheduler (Automated Fetching)** | ⬜ Pending |
| | **Refine Gemini Summaries** | ⬜ Pending |
| | Expose stable API endpoints | ✅ Done |
| **3. Frontend** | **Refine UI & Navigation (Linux First)** | ⬜ Pending |
| | PDF/Source opening integration | ✅ Done |
| | Configurable API URL (LAN support) | ✅ Done |
| | **Initialize & Fix Android Build** | ⬜ Pending |
| **4. Desktop** | Linux desktop validation & layout check | ⬜ Pending |
| **5. Deployment** | **Deploy & Test on Local Ubuntu Server** | ⬜ Pending |
| | **Setup Android Connection (LAN/Tailscale)** | ⬜ Pending |
| | **Build & Run Signed APK on Phone** | ⬜ Pending |
| | Upload to GitHub Releases | ⬜ Pending |

## 5. Troubleshooting
- **API Connection Error**: Android Emulator uses `10.0.2.2` to access localhost. This is configured in `frontend/lib/services/api_service.dart`. If running on a physical device, update `serverIp` in that file.
- **PDF Not Opening**: Ensure an app capable of opening PDFs is installed on the emulator/device.
