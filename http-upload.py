#!/usr/bin/env python3
#
# Simple file upload server

import os, sys, io, http.server, socket
from socketserver import TCPServer, BaseRequestHandler


PORT = 8000
UPLOAD_DIR = "."

HTML = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>HTTP Upload</title>
    <style>
        body { font-family: monospace; letter-spacing: 0.03em; margin: 10px; }
        a, a:visited, a:hover { color: blue; text-decoration: none; }
        h1 { font-size: 18px; }
        h2 { font-size: 14px; color: #666; font-style: italic; font-weight: normal; }
        button { background: steelblue; color: white; font-size: 14px; font-weight: bold; width: 100%; padding: 10px; border: none; border-radius: 5px; text-align: center; cursor: pointer; }
        ul { background: #eee; padding: 10px; border-radius: 5px; line-height: 1.8em; margin: 10px 0 0 0; list-style: none; }
        ul li { font-size: 14px; }
    </style>
</head>
<body>
    <h1>Upload a File</h1>
    <form enctype="multipart/form-data" method="post">
        <input type="file" name="file" required>
        <input type="submit" value="Upload">
    </form>
    <br>
    <label id="result"></label>
    <script>
        function result(status, message) {
            const res = document.getElementById("result");
            (status) ? res.style.color = "green" : res.style.color = "indianred";
            res.innerHTML = message;
            setTimeout(() => {
                res.innerHTML = "";
                window.location = "/";
            }, 2500);
        }
    </script>
</body>
</html>
""".encode('utf-8')

class UploadHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        if content_length == 0:
            self.send_response(400)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(HTML)
            self.wfile.write(b'<script>result(false, "No file data received.")</script>')
            return

        boundary = self.headers.get('Content-Type').split('boundary=')[1].encode()
        data = self.rfile.read(content_length)
        parts = data.split(b'--' + boundary)

        for part in parts:
            if b'filename="' in part:
                filename_start = part.find(b'filename="') + len(b'filename="')
                filename_end = part.find(b'"', filename_start)
                filename = part[filename_start:filename_end].decode()
                if not filename:
                    continue

                content_start = part.find(b'\r\n\r\n') + 4
                content_end = part.rfind(b'\r\n--')
                file_content = part[content_start:content_end]

                file_path = os.path.join(UPLOAD_DIR, os.path.basename(filename))
                with open(file_path, 'wb') as f:
                    f.write(file_content)

                self.send_response(303)
                self.send_header('Location', '/success?filename=' + filename)
                self.end_headers()
                return

        self.send_response(400)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(HTML)
        self.wfile.write(b'<script>result(false, "No valid file found in upload.")</script>')

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(HTML)

        if self.path.startswith('/success'):
            self.wfile.write(b'<script>result(true, "File uploaded successfully!")</script>')


class ReusableTCPServer(TCPServer):
    def server_bind(self):
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        super().server_bind()


if __name__ == '__main__':
    try:
        httpd = ReusableTCPServer(("", PORT), UploadHandler)
        print(f"Serving HTTP on 0.0.0.0 port {PORT} (http://0.0.0.0:{PORT}/) ...")
        httpd.serve_forever()
    except KeyboardInterrupt:
        sys.exit()
