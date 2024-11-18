#!/usr/bin/env python3
#
# Custom chat completion using Llama-cpp
#
# llama-chat.py      : Continues learning by user interactions
# llama-chat.py gram : English grammar checker (no memory)
# llama-chat.py code : Answer code related questions (no memory)
#
# read command-line output: $(cat script.py)
#
# /save: save the long-term memory to current directory
# /speak: speaks the last assistant memory
# /exit or /quit


import gc, os, sys, json, re, requests, datetime, random, subprocess
import readline
class col: MAGENTA = '\033[95m'; BLUE = '\033[94m'; CYAN = '\033[96m'; GREEN = '\033[92m'; YELLOW = '\033[93m'; RED = '\033[91m'; END = '\033[0m'; BOLD = '\033[1m'; UNDERLINE = '\033[4m'


USER = __import__('getpass').getuser()
SYSTEM_MAIN = "You are Llamas, an AI assistant. Keep responses short."
SYSTEM_GRAM = "You are an English Language Teacher. Explain and correct grammatical errors."
SYSTEM_CODE = "You are a Computer Programmer. Write codes precisely. Less words, more codes."
MAX_SHORT_MEM = 20
PORT = 8012


class Llama():
    def __init__(self):
        self.memory = [{ "role": "system", "content": SYSTEM_MAIN }]
        self.memory_long = [{ "role": "system", "content": SYSTEM_MAIN }]
        self.seed = 42 if datetime.datetime.now().hour % 2 == 0 else 13
        self.temperature = round(random.uniform(0.7, 0.8), 2)


    def pre_processor(self):
        prompt = input(col.GREEN + ": ")
        print(end=col.END)
        prompt = self.read_cmd(prompt)
        if not self.commander(prompt.lower()):
            return prompt
        return None


    def processor(self, messages, stream=True):
        data = {
            "messages": messages,
            "seed": self.seed,
            "temperature": self.temperature,
            "stream": stream
        }

        response = requests.post(
            f"http://0.0.0.0:{PORT}/v1/chat/completions",
            headers = { "Content-Type": "application/json" },
            data = json.dumps(data),
            stream = stream)
        response.raise_for_status()
        
        content = ""
        if stream:
            for line in response.iter_lines():
                if line:
                    decoded = line.decode("utf-8").lstrip("data: ")
                    try:
                        data = json.loads(decoded)
                        if "choices" in data and len(data["choices"]) > 0:
                            delta = data["choices"][0].get("delta", {})
                            piece = delta.get("content", "")
                            content += piece
                            print(piece, end="", flush=True)
                    except json.JSONDecodeError:
                        continue
            print()
        else:
            result = response.json()
            if "choices" in result and len(result["choices"]) > 0:
                content = result["choices"][0]["message"]["content"]

        return content


    def autochat(self):
        while True:
            prompt = self.pre_processor()
            if prompt:
                messages = [{ "role": "user", "content": prompt }]

                self.memory += messages
                self.memory_long += messages

                response = self.processor(self.memory)

                self.memory += [{ "role": "assistant", "content": response }]
                self.memory_long += [{ "role": "assistant", "content": response }]
                if len(self.memory) > MAX_SHORT_MEM:
                    self.memory = self.memory[-MAX_SHORT_MEM:]


    def task_gram(self):
        while True:
            prompt = self.pre_processor()
            if prompt:
                messages = [
                    { "role": "system", "content": SYSTEM_GRAM },
                    { "role": "user", "content": f"1- Check this text for grammatical errors: {prompt}" },
                    { "role": "user", "content": f"2- Summarize the text" }
                ]
                self.processor(messages)


    def task_code(self):
        while True:
            prompt = self.pre_processor()
            if prompt:
                messages = [
                    { "role": "system", "content": SYSTEM_CODE },
                    { "role": "user", "content": prompt }
                ]
                self.processor(messages)


    def read_cmd(self, prompt):
        cmd = re.findall(r'\$\(([^}]+)\)', prompt)
        if cmd:
            process = subprocess.Popen(cmd[0].split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = process.communicate()
            result = stdout if not stderr else stderr
            prompt = prompt.replace(f"$({cmd[0]})", result.decode("utf-8").strip())
        return prompt


    def commander(self, prompt):
        if prompt in ["/exit", "/quit"]:
            gc.collect()
            sys.exit(0)

        if prompt == "/save":
            count = 1
            fname = "llama_mem"
            fpath = f"./{fname}"
            while os.path.exists(fpath):
                fpath = f"./{fname}_{str(count)}"
                count += 1
            open(fpath, 'w').write(json.dumps(self.memory_long, indent=4))
            return True

        elif prompt == "/speak":
            text = None
            for mem in self.memory:
                if mem["role"] == "assistant":
                    text = mem["content"]
            if text:
                self.speaker(text)
            return True

        return False


    def speaker(self, text):
        text = text.strip()
        text = text.replace('"', r'\"')
        text = text.replace("'", r"\'")
        text = text.replace("`", r"\`")
        os.system(f'speak "{text}"')


if __name__ == "__main__":
    llama = Llama()

    try:
        if len(sys.argv) > 1:
            match sys.argv[1]:
                case 'gram': llama.task_gram()
                case 'code': llama.task_code()
                case _:
                    print("help: python3 llama-chat.py [gram, code, ...]")
        else:
            llama.autochat()
    except KeyboardInterrupt:
        print()

    gc.collect()
