#!/usr/bin/env python3
# Aug 2024 https://nimadez.github.io/
#
# No modules required, vanilla as usual!
#
# Inference:
#   Chat: python3 ollama.py
#   Generate: python3 ollama.py "text"
#   Direct module import: see 'ollama-gram.py' example
#
# flite required for TTS, see 'speak.sh' file


import os, sys, json, http.client, datetime, random
import readline # support arrow keys for inputs
from urllib import request
class col: MAGENTA = '\033[95m'; BLUE = '\033[94m'; CYAN = '\033[96m'; GREEN = '\033[92m'; YELLOW = '\033[93m'; RED = '\033[91m'; END = '\033[0m'; BOLD = '\033[1m'; UNDERLINE = '\033[4m'


VER = "1.0.1"
USER = __import__('getpass').getuser()
OLLAMA_BINARY = f"/media/{USER}/local/apps/ollama/ollama"
OLLAMA_MODELS = f"/media/{USER}/local/ml/ollama"
PORT = 11434
MODEL = "llama31_8B_Q4_K_M"
SYSTEM = "You are Axa, an AI assistant. Keep responses short."
MAX_SHORT_MEM = 20


os.environ["OLLAMA_HOST"] = "0.0.0.0"
os.environ["OLLAMA_MODELS"] = OLLAMA_MODELS
os.environ["OLLAMA_TMPDIR"] = f"{OLLAMA_MODELS}/temp"
os.environ["OLLAMA_RUNNERS_DIR"] = f"{OLLAMA_MODELS}/runners"
os.environ["OLLAMA_NOHISTORY"] = "true"
os.environ["OLLAMA_INTEL_GPU"] = "false"
os.environ["CUDA_VISIBLE_DEVICES"] = "0"


class Ollama():
    def __init__(self):
        self.memory = [{ "role": "system", "content": SYSTEM }]
        self.memory_long = [{ "role": "system", "content": SYSTEM }]
        self.options = { # change seed based on even/odd hour (a little bipolar!)
            "seed": 48 if datetime.datetime.now().hour % 2 == 0 else 13,
            "temperature": round(random.uniform(0.8, 0.9), 2), # (a bit mood swings!)
            "low_vram": True
        }


    # continues learning by user interactions
    # can be used to perform multiple tasks 'e.g. ollama-gram.py'
    # commands:
    #   /save       save the memory snapshot
    #   /speak      speaks the last answer
    def chat(self, messages):
        for i in range(len(messages)):
            messages[i]["content"] = messages[i]["content"].strip()

        if self.commander(messages[0]["content"]):
            return

        self.memory += messages
        self.memory_long += messages

        payload = {
            "model": MODEL,
            "messages": self.memory,
            "stream": True,
            "options": self.options
        }

        return self.processor(payload, True)


    # for single run-and-forget tasks
    def generate(self, prompt, is_speak=False):
        payload = {
            "model": MODEL,
            "prompt": prompt.strip(),
            "stream": False,
            "options": self.options
        }

        content = self.processor(payload, False)
        if is_speak:
            self.speaker(content)

        return content


    def processor(self, payload, is_chat):
        data = str(json.dumps(payload)).encode("utf-8")
        content = None

        if is_chat:
            conn = http.client.HTTPConnection('localhost', PORT)
            conn.request("POST", "/api/chat", data, { 'Content-Type': 'application/json' })
            response = conn.getresponse()

            if response.status == 200:
                content = ''
                for chunk in response:
                    for d in self.parser(chunk):
                        data = json.loads(d)
                        if not data["done"]:
                            print(col.CYAN + data['message']['content'] + col.END, end='', flush=True)
                            content += data['message']['content']
                print()

                self.memory += [{ "role": "assistant", "content": content }]
                self.memory_long += [{ "role": "assistant", "content": content }]
                if len(self.memory) > MAX_SHORT_MEM:
                    self.memory = self.memory[-MAX_SHORT_MEM:]
        else:
            req = request.Request(f'http://localhost:{PORT}/api/generate', data=data)
            resp = request.urlopen(req)
            responses = resp.read().decode("utf-8").split("\n")

            data = json.loads(responses[0])
            print(col.CYAN + data['response'] + col.END)
            content = data['response']

        return content


    def parser(self, data):
        for ev in data.decode("utf-8").split("\n"):
            if not ev:
                continue
            yield ev


    def commander(self, data, cmd=None):
        try:
            cmd = data.split('/')[1]
        except:
            pass
        if cmd:
            match cmd:
                case 'save':
                    self.snapshot()
                    return True
                case 'speak':
                    content = None
                    for mem in self.memory:
                        if mem["role"] == "assistant":
                            content = mem["content"]
                    if content:
                        self.speaker(content)
                    return True
        return False


    def snapshot(self):
        count = 1
        fpath = f"/home/{USER}/.ollama/snapshot"
        while os.path.exists(fpath):
            fpath = f"/home/{USER}/.ollama/snapshot_{str(count)}"
            count += 1
            
        with open(fpath, "w") as f:
            for mem in self.memory_long:
                f.write(f"{mem}\n")


    def speaker(self, text):
        text = text.strip()
        text = text.replace('"', r'\"')
        text = text.replace("'", r"\'")
        text = text.replace("`", r"\`")
        os.system(f'speak "{text}"')


if __name__== "__main__":
    os.system(f"gnome-terminal --tab -- {OLLAMA_BINARY} serve")

    ollama = Ollama()

    if len(sys.argv) > 1:
        ollama.generate(sys.argv[1])
    else:
        try:
            while True:
                prompt = input(": ")
                messages = [{ 'role': 'user', 'content': prompt }]
                ollama.chat(messages)
        except KeyboardInterrupt:
            print()
