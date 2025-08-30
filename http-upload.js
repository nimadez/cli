#!/usr/bin/env node
//
// File upload/download server

const http = require('http');
const fs = require('fs').promises;
const path = require('path');
const url = require('url');

const PORT = 8000;
const ROOT = process.cwd();

const server = http.createServer(async (req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const pathname = parsedUrl.pathname;
    const filePath = path.join(ROOT, pathname.replace('/download/', ''));

    // Index directory listing (ignore subdirectories)

    if (req.method === 'GET' && pathname === '/') {
        try {
            const files = await fs.readdir(filePath, { withFileTypes: true });
            const fileLinks = files
                .filter(dir => dir.isFile())
                .map(file =>
                    `<a href="/download${pathname.endsWith('/') ? pathname : pathname + '/'}${file.name}">${file.name}</a><br>`
                ).join('');

            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(`
                <!DOCTYPE html>
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
                    <title>Node File Server</title>
                    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📂</text></svg>">
                    <style>
                        body { font-family: monospace; font-size: 14px; margin: 10px; }
                        a, a:visited, a:hover { color: blue; text-decoration: none; }
                        h1 { font-size: 16px; }
                    </style>
                </head>
                <body>
                    <h1>${ROOT}</h1>
                    <form method="post" enctype="multipart/form-data" action="/upload">
                        <input type="file" name="file">
                        <input type="submit" value="Upload">
                    </form>
                    <hr>
                    <div>${fileLinks}</div>
                </body>
            `);
        } catch (err) {
            res.writeHead(404);
            res.end('File not found');
        }
        return;
    }

    // File download

    if (req.method === 'GET' && pathname.startsWith('/download')) {
        try {
            const content = await fs.readFile(filePath);

            console.log(`Download: ${path.basename(filePath)}`);
            res.writeHead(200, {
                'Content-Type': 'application/octet-stream',
                'Content-Disposition': `attachment; filename="${path.basename(filePath)}"`
            });
            res.end(content);
        } catch (err) {
            res.writeHead(404);
            res.end('File not found');
        }
        return;
    }

    // File upload

    if (req.method === 'POST' && pathname === '/upload') {
        let body = [];
        req.on('data', chunk => body.push(chunk));
        req.on('end', async () => {
            try {
                const boundary = req.headers['content-type'].split('boundary=')[1];
                const parts = Buffer.concat(body).toString().split(`--${boundary}`);

                for (const part of parts) {
                    if (part.includes('filename=')) {
                        const filenameMatch = part.match(/filename="(.+?)"/);
                        if (!filenameMatch) continue;

                        const filename = filenameMatch[1];
                        const filePath = path.join(ROOT, filename);
                        const fileContent = part.split('\r\n\r\n')[1].split('\r\n--')[0];
                        await fs.writeFile(filePath, fileContent);

                        console.log(`Upload:   ${path.basename(filePath)}`);
                        res.writeHead(200, { 'Content-Type': 'text/html' });
                        res.end('<script>window.location.replace("/");</script>');
                        return;
                    }
                }
                res.writeHead(400, { 'Content-Type': 'text/html' });
                res.end('<script>window.location.replace("/");</script>');
            } catch (err) {
                res.writeHead(500);
                res.end('Error uploading file');
            }
        });
        return;
    }

    res.writeHead(404);
    res.end('Error 404');
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
