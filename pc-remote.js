const http = require('http');
const exec = require('child_process').exec;

const HTML =
`<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>PC Remote</title>
    <style>
        html, body { overscroll-behavior: contain; user-select: none; overflow: hidden; }
        body { font-family: sans-serif; text-align: center; background: #191d24; color: #eee; margin: 10px; }
        h1 { font-size: 11px; color: indianred; }
        button { width: 60px; padding: 8px 3px 6px 3px; margin-bottom: 5px; background: slategray; color: #111; font-size: 11px; font-weight: bold; border-radius: 3px; border: none; }
        input[type=text] { width: 100px; padding: 2px; background: slategray; color: #111; border-radius: 3px; text-align: center; border: none; outline: none; }
        input[type=text]::placeholder { color: #111; }
        canvas { width: 320px; height: 180px; background: #464856; background-image: linear-gradient(#ffffff0c 2px, transparent 2px), linear-gradient(90deg, #ffffff0c 2px, transparent 2px), linear-gradient(#ffffff07 1px, transparent 1px), linear-gradient(90deg, #ffffff07 1px, transparent 1px); background-size: 160px 90px;  border-radius: 5px; }
        form { margin: 0; }
        #collapsible { display: none; }
    </style>
</head>
<body>
    <form action="/" method="post">
        <h1>APPS</h1>
        <button name="magnify">Magnify</button>
        <button name="explorer">Explorer</button>
        <button name="chrome">Chrome</button>
        <button name="tor">TOR</button>

        <h1>MOUSE</h1>
        <canvas></canvas></br>
        <div>
            <button name="leftclick" style="width:155px;height:30px">LEFT</button>
            <button name="rightclick" style="width:155px;height:30px">RIGHT</button>
        </div>

        <h1>KEYBOARD</h1>
        <button name="escape">ESC</button>
        <button name="f4">F4</button>
        <button name="f5">F5</button>
        <button name="f11">F11</button>
        <button name="backspace">BACK</button></br>
        <button name="tab">TAB</button>
        <button name="enter">ENTER</button>
        <button name="up">↑</button>
        <button name="minus">–</button>
        <button name="divide">/</button></br>
        <button name="space">SPACE</button>
        <button name="left">←</button>
        <button name="down">↓</button>
        <button name="right">→</button>
        <button name="win">WIN</button>

        <button style="display:none" name="leftclick"></button>
        <button style="display:none" name="rightclick"></button>
        <button style="display:none" id="pos" name="0"></button>
    </form>
    <form action="/" method="post">
        <input type="text" name="type" placeholder="09 AZ az"/>
    </form>
    <form action="/" method="post">
        <h1>VOLUME</h1>
        <button name="voldown">–</button>
        <button name="volmute">MUTE</button>
        <button name="volup">+</button>
    </form>
    <h1>SHUTDOWN</h1>
    <button type="button" onclick="document.getElementById('collapsible').style.display='unset';this.style.display='none'">SHOW</button>
    <form action="/" method="post" id="collapsible">
        <button name="monitor">Monitor</button>
        <button name="sleep">Sleep</button>
        <button name="shutdown">Shutdown</button>
    </form>
</body>
<script>
    const canvas = document.querySelectorAll('canvas')[0];
    const pos = document.getElementById('pos');
    let initialX, initialY, absX, absY;

    canvas.addEventListener("touchstart", function(e) {
        initialX = e.touches[0].clientX;
        initialY = e.touches[0].clientY;
        if (e.touches.length > 1)
            document.getElementsByName('rightclick')[0].click();
    }, false);

    canvas.addEventListener("touchmove", function(e) {
        let diffX = initialX - e.touches[0].clientX;
        let diffY = initialY - e.touches[0].clientY;
        absX = Math.abs(diffX);
        absY = Math.abs(diffY);
        if (absX > absY) {
            if (diffX > 0) { //left
                pos.name = "pos=-" + absX/2 + "&0";
            } else { //right
                pos.name = "pos=" + absX/2 + "&0";
            }
        } else {
            if (diffY > 0) { //up
                pos.name = "pos=0" + "&-" + absY/2;
            } else { //down
                pos.name = "pos=0" + "&" + absY/2;
            }
        }
        pos.click();
        e.preventDefault();
    }, false);
    
    canvas.addEventListener("click", function() {
        document.getElementsByName('leftclick')[0].click();
    }, false);
</script>
</html>`;

const PORT = process.argv[2] || 3000;
const httpServer = http.createServer(requestHandler);
httpServer.listen(PORT, () => {
    console.log(':: Server is listening on port ' + PORT);
});

function requestHandler(req, res) {
    let msgArray, msgKey = [];
    if (req.method == 'POST') {
        let msg = '';
        req.on('data', function (data) {
            msg += data;
        });
        req.on('end', function () {
            msg = decodeURIComponent(msg);
            msgArray = msg.split('=');
            switch (msgArray[0]) {
                case 'pos':
                    msgKey = msgArray[1].split('&');
                    runCMD(`pc-control mouse ${msgKey[0]} ${msgKey[1]}`);
                    break;
                case 'volup':
                    runCMD('pc-control volume up');
                    break;
                case 'voldown':
                    runCMD('pc-control volume down');
                    break;
                case 'volmute':
                    runCMD('pc-control volume mute');
                    break;
                case 'leftclick':
                    runCMD('pc-control click left 1');
                    break;
                case 'rightclick':
                    runCMD('pc-control click right 1');
                    break;
                case 'type':
                    runCMD(`pc-control type "${msgArray[1]}"`);
                    break;
                case 'escape':
                    runCMD('pc-control key escape');
                    break;
                case 'space':
                    runCMD('pc-control key space');
                    break;
                case 'enter':
                    runCMD('pc-control key enter');
                    break;
                case 'left':
                    runCMD('pc-control key left');
                    break;
                case 'right':
                    runCMD('pc-control key right');
                    break;
                case 'up':
                    runCMD('pc-control key up');
                    break;
                case 'down':
                    runCMD('pc-control key down');
                    break;
                case 'f4':
                    runCMD('pc-control key f4');
                    break;
                case 'f5':
                    runCMD('pc-control key f5');
                    break;
                case 'f11':
                    runCMD('pc-control key f11');
                    break;
                case 'divide':
                    runCMD('pc-control key /');
                    break;
                case 'minus':
                    runCMD('pc-control key -');
                    break;    
                case 'tab':
                    runCMD('pc-control key tab');
                    break;
                case 'backspace':
                    runCMD('pc-control key backspace');
                    break;
                case 'win':
                    runCMD('pc-control key win');
                    break;
                case 'monitor':
                    runCMD('pc-control shutdown monitor');
                    break;
                case 'sleep':
                    runCMD('pc-control shutdown sleep');
                    break;
                case 'shutdown':
                    runCMD('pc-control shutdown shutdown');
                    break;
                case 'magnify':
                    runCMD('start magnify');
                    break;
                case 'explorer':
                    runCMD('start explorer');
                    break;
                case 'chrome':
                    runCMD('start "" "%ProgramFiles%/Google/Chrome/Application/chrome.exe"');
                    break;
                case 'tor':
                    runCMD('start D:/Apps/Tor/TOR.lnk');
                    break;
            }
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end(HTML);
        });
    } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end(HTML);
    }
}

function runCMD(cmd) {
    exec(cmd, (error, stdout, stderr) => {
        if (error !== null) console.log(`exec error: ${error}`);
    });
}
