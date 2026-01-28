# GitHub & Mobile Guide

## 1. Push to GitHub
I have already initialized the git repository and created the `.gitignore`.

1. **Create a new Empty Repository** on GitHub (do not add README/License).
2. **Push your code**:
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/footnote.git
   git branch -M main
   git push -u origin main
   ```

## 2. Run on Android Phone (Physical Device)
To connect your phone to the backend running on your computer:

1. **Ensure both devices are on the same Wi-Fi**.
2. **Check your Computer's IP**:
   I detected it as `172.22.160.200`. (Run `hostname -I` to confirm).
   I have updated `frontend/lib/services/api_service.dart` with this IP.
3. **Allow Port 8000 through Firewall**:
   If using Ubuntu/UFW:
   ```bash
   sudo ufw allow 8000/tcp
   ```
4. **Run the App**:
   Connect your phone via USB and run:
   ```bash
   cd frontend
   flutter run
   ```

## 3. Run as a Server
To run the backend permanently (so your phone can always access it):

```bash
# In project root
source venv/bin/activate
# listen on 0.0.0.0 (all interfaces)
uvicorn backend.app.main:app --host 0.0.0.0 --port 8000
```
