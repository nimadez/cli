#!/usr/bin/env python3
from ollama import Ollama


if __name__== "__main__":
    ollama = Ollama()
    try:
        while True:
            prompt = input(": ")
            messages = [
                { 'role': 'user', 'content': f"Check grammar of this text: {prompt}" },
                { 'role': 'user', 'content': f"Summarize this text: {prompt}" },
                { 'role': 'user', 'content': f"Rewrite this text in 240 chars: {prompt}" }
            ]
            ollama.chat(messages)
    except KeyboardInterrupt:
        print()
