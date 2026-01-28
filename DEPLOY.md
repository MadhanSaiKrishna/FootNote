# Deploying Footnote on a Personal Server (Self-Hosted)

Since you have your own Linux server (VPS like AWS EC2, DigitalOcean, or a Raspberry Pi), here is how to deploy it robustly.

We will use `systemd` to make sure the app runs in the background and restarts automatically if it crashes or the server reboots.

## 1. Prerequisites (On Server)
SSH into your server and ensure Python is installed:
```bash
sudo apt update
sudo apt install python3 python3-venv git nginx
```

## 2. Setup the Code
Clone your repo to the server (replace URL with your repo):
```bash
cd /opt
sudo git clone https://github.com/YOUR_USER/footnote.git
sudo chown -R $USER:$USER footnote
cd footnote
```

## 3. Setup Environment
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
# Manually populate DB first time
python scripts/manual_fetch.py
```

## 4. Create a Service (Systemd)
This keeps the app running 24/7.

Create a file `/etc/systemd/system/footnote.service`:
`sudo nano /etc/systemd/system/footnote.service`

Paste this (Update `User` and paths to match your server):
```ini
[Unit]
Description=Footnote Backend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/footnote
# Command to run uvicorn from the venv
ExecStart=/opt/footnote/backend/venv/bin/uvicorn backend.app.main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable and start it:
```bash
sudo systemctl daemon-reload
sudo systemctl enable footnote
sudo systemctl start footnote
```

## 5. Expose to the Internet
Now your API behaves like a real production server.
- **Your API URL**: `http://YOUR_SERVER_IP:8000`

### Optional: Use Nginx (Reverse Proxy)
To access it on port 80 (standard HTTP) instead of 8000:
`sudo nano /etc/nginx/sites-available/footnote`

```nginx
server {
    listen 80;
    server_name YOUR_DOMAIN_OR_IP;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```
Enable it:
```bash
sudo ln -s /etc/nginx/sites-available/footnote /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

## 6. Update Flutter App
Now that your backend is live, update your `api_service.dart` in Flutter to point to your real server instead of `localhost`.

File: `frontend/lib/services/api_service.dart`
```dart
String get baseUrl {
  // Use your real server IP now!
  return 'http://YOUR_SERVER_IP:8000'; 
}
```
