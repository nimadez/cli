const http = require('http');
const fs = require('fs');
const path = require('path');

const INDX = 'http-upload.html';
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
    const index = path.join(__dirname, INDX); // use script path
    fs.readFile(index, (err, content) => {
        if (err) {
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            res.write('Index not found!');
            res.end();
        } else {
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.write(content);
            res.end();
        }
    });
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
