#!/usr/bin/env node
//
// Simple file upload/download server

const HTML = `<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
  	<title>Node File Server</title>
	<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📂</text></svg>" />
	<style>
		body { font-family: monospace; margin: 10px; }
		a, a:visited { color: steelblue; text-decoration: none; }
		a:hover { color: blue; }
		h1 { font-size: 20px; }
		button { background: steelblue; color: white; padding: 10px; border: none; border-radius: 5px; text-align: center; cursor: pointer; }
		ul { background: #eee; padding: 5px; border-radius: 5px; margin: 0; list-style: none; }
		ul li { font-size: 14px; font-weight: bold; }
		#path { font-size: 11px; color: #666; padding: 5px; letter-spacing: 0.1em; }
		.unsupported a { color: gray; }
	</style>
</head>
<body>
	<h1>Node File Server</h1>
	<button onclick="document.getElementById('upload').click()">UPLOAD</button>
	<div id="path">></div>
	<ul id="list"></ul>
	<input style="display:none" id="upload" type="file" onchange="uploadFile(event)">
</body>
<script>
	loadFiles();

	function loadFiles() {
		const xhr = new XMLHttpRequest();
		xhr.open('GET', '/list', true);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					const res = JSON.parse(xhr.responseText);
					if (res.length > 0) {
						let data = "";
						for (let i = 0; i < res.length; i++) {
							if (res[i].startsWith('/')) {
								data += "<li class='unsupported'><a href='/download" + res[i] + "'>" + res[i] + "</a></li>";
							} else {
								data += "<li><a href='/download/" + res[i] + "'>$" + res[i] + "</a></li>";
							}
						}
						document.getElementById('list').innerHTML = data;
						getPath();
					}
				}
			}
		}
		xhr.send();
	}

	function uploadFile(evt) {
		const target = evt.target || evt.srcElement || evt.currentTarget;
		const file = target.files[0];
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/upload/' + file.name, true);
		xhr.setRequestHeader('Content-Type', 'application/octate-stream');
		xhr.onreadystatechange = function () {
			evt = null;
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					loadFiles();
				} else {
					console.log('Unable to Upload');
				}
			}
		}
		xhr.send(file);
	}

	function getPath() {
		const xhr = new XMLHttpRequest();
		xhr.open('GET', '/path', true);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					const res = JSON.parse(xhr.responseText);
					if (res.length > 0) {
						document.getElementById('path').innerHTML = res;
					} else {
						document.getElementById('path').innerHTML = 'Unable to resolve path';
					}
				}
			}
		}
		xhr.send();
	}
</script>
</html>`

const http = require('http');
const fs = require('fs');
const path = require('path');

const ROOT = process.cwd();
const PORT = process.argv[2] || 3000;

const mimeTypes = {
    ".html" : "text/html",
    ".htm"  : "text/html",
    ".xhtml": "application/xhtml+xml",
    ".txt"  : "text/plain",
    ".xml"  : "application/xml",
    ".css"	: "text/css",
    ".js"	: "text/javascript",
    ".cpp"  : "text/plain",
    ".py"   : "text/x-python",
    ".bat"  : "text/plain",
    ".vbs"  : "text/plain",
    ".ini"  : "text/plain",
    ".cfg"  : "text/plain",
    ".md"   : "text/plain",
    ".sh"   : "text/plain", //"application/x-sh",
    ".json"	: "application/json",
    ".svg"	: "image/svg+xml",
    ".jpg"	: "image/jpg",
    ".jpeg"	: "image/jpg",
    ".png"	: "image/png",
    ".gif"	: "image/gif",
    ".tif"	: "image/tiff",
    ".tiff"	: "image/tiff",
    ".ico"	: "image/x-icon",
    ".ttf"	: "font/ttf",
    ".woff"	: "font/woff",
    ".woff2": "font/woff2",
    ".mp3"	: "audio/mpeg",
    ".wav"	: "audio/wav",
    ".mp4"	: "video/mp4",
    ".weba"	: "audio/webm",
    ".webm"	: "video/webm",
    ".pdf"	: "application/pdf",
    ".7z"	: "application/x-7z-compressed",
    ".zip"	: "application/zip",
    ".rar"	: "application/vnd.rar"
}

const httpServer = http.createServer(requestHandler);
httpServer.listen(PORT, () => {
    console.log(':: Server is listening on port http://localhost:' + PORT);
});

function requestHandler(req, res) {
    if (req.url === '/') {
        sendIndex(res);
    } else if (req.url === '/list') {
        sendListFiles(res);
    } else if (req.url === '/path') {
        sendCurrentPath(res);
    } else if (/\/download\/[^\/]+$/.test(req.url)) {
        sendDownloadFile(req.url, res);
    } else if (/\/upload\/[^\/]+$/.test(req.url)) {
        sendUploadFile(req, res);
    } else {
        sendInvalidRequest(res);
    }
}

function sendIndex(res) {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.write(HTML);
    res.end();
}

function sendListFiles(res) {
    fs.readdir(ROOT, (err, files) => {
        if (err) {
            res.writeHead(400, { 'Content-Type': 'application/json' });
            res.write(JSON.stringify(err.message));
            res.end();
            console.log(err.message);
        } else {
            let sorted = [];
            let count = 0;
            // detect and sort by directories
            for (let i = 0; i < files.length; i++) {
                if (fs.lstatSync(files[i]).isDirectory()) {
                    sorted[count] = '/' + files[i];
                    count++;
                }
            }
            // add files
            for (let i = 0; i < files.length; i++) {
                if (fs.lstatSync(files[i]).isFile()) {
                    sorted[count] = files[i];
                    count++;
                }
            }
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.write(JSON.stringify(sorted));
            res.end();
        }
    });
}

function sendDownloadFile(url, res) {
    const fileName = path.basename(url);
    const file = path.join(ROOT, fileName);

    if (fs.lstatSync(file).isDirectory()) {
        console.log('Directory is not supported');
        return;
    }
    
    fs.readFile(file, (err, content) => {
        if (err) {
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            res.write('Error: "' + fileName + '" not found');
            res.end();
            console.log('Error: "' + fileName + '" not found');
        } else {
            const ext = path.extname(fileName);
            let mimeType = mimeTypes[ext];
            if (!mimeType) {
                mimeType = 'application/octet-stream';
            }
            res.writeHead(200, { 'Content-Type': mimeType });
            res.write(content);
            res.end();
            console.log('Download: "' + fileName + '"');
        }
    });
}

function sendUploadFile(req, res) {
    const fileName = path.basename(req.url);
    const file = path.join(ROOT, fileName);
    req.pipe(fs.createWriteStream(file));
    req.on('end', () => {
        console.log('Upload: "' + fileName + '"');
        sendListFiles(res);
    });
}

function sendCurrentPath(res) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.write(JSON.stringify(ROOT));
    res.end();
}

function sendInvalidRequest(res) {
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.write('Invalid Request');
    res.end();
}
