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

## 3. Server Setup (Raspberry Pi / Linux)
This guide assumes you are running the backend on a headless server (e.g., Raspberry Pi) connected to your LAN.

### Minimum Specs (Raspberry Pi)
- **Model**: Raspberry Pi 3B+ or Raspberry Pi 4 (Any RAM model)
- **RAM**: 1GB+ (Sufficient since AI inference is offloaded to Gemini API)
- **OS**: Raspberry Pi OS Bookworm (64-bit Lite)
- **Storage**: 16GB+ microSD card


### Server Installation
1. **Clone & Setup**:
   ```bash
   git clone https://github.com/MadhanSaiKrishna/FootNote.git
   cd FootNote
   python3 -m venv venv
   source venv/bin/activate
   pip install -r backend/requirements.txt
   ```
2. **Run as Service (Systemd)**:
   Create a service file to keep it running 24/7.
   ```bash
   sudo nano /etc/systemd/system/footnote.service
   ```
   Add:
   ```ini
   [Unit]
   Description=Footnote Backend
   After=network.target

   [Service]
   User=pi
   WorkingDirectory=/home/pi/FootNote
   ExecStart=/home/pi/FootNote/venv/bin/uvicorn backend.app.main:app --host 0.0.0.0 --port 8000
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```
   Enable it:
   ```bash
   sudo systemctl enable --now footnote.service
   ```

### Linux Desktop Client
If you are developing the *frontend* on a Linux Desktop:
1. **Enable Desktop**: `flutter config --enable-linux-desktop`
2. **Run**: `flutter run -d linux`

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
| **5. Deployment** | **Setup Raspberry Pi Server (Headless)** | ⬜ Pending |
| | **Configure Tailscale/VPN Access** | ⬜ Pending |
| | **Build & Run Signed APK on Phone** | ⬜ Pending |
| | Upload to GitHub Releases | ⬜ Pending |

## 5. Troubleshooting
- **API Connection Error**: Android Emulator uses `10.0.2.2` to access localhost. This is configured in `frontend/lib/services/api_service.dart`. If running on a physical device, update `serverIp` in that file.
- **PDF Not Opening**: Ensure an app capable of opening PDFs is installed on the emulator/device.
