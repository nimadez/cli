# CLI
**Debian Assistant CLI**<br>
For version 13 "Trixie" in testing branch<br>
Kernel: 6.9.12

> - **.obsolete**: unused scripts
> - **.patch**: scripts that are rarely used
> - **.windows**: frozen windows scripts

<details>
<summary>
🔷&nbsp;&nbsp;<b>Show Details</b>
</summary>&nbsp;

| Script | Description |
| ------- | --- |
| about | Get general information about the system |
| about-kernel | Debug kernel messages |
| adb-debloat | Debloat android device with a given list |
| adb-pm-enable | Re-enable by package id |
| adb-pm-list | List all/enabled/disabled packages |
| adb | A quick launch for adb |
| apt-download | Download .deb package without installation |
| apt-history | Show apt run history and what was done |
| apt-info | Show package info, dependencies and locations |
| apt-install-free | Install common free software |
| apt-install-gnome | Install gnome-core and gnome software |
| apt-install-headers | Install linux kernel headers |
| apt-install-nvidia | Install nvidia driver |
| apt-install-vm | Install gnome-boxes and libvirt daemon |
| apt-list | List installed software |
| apt-source-gen | Generate debian sources.list |
| apt-unlock | Unlock apt and fix corrupted install |
| aria2 | Aria2c downloader with built-in config file |
| backup-disk | Sync local disk to external hard disk |
| backup-home | Backup home directory to tar archive |
| batch-rename | Rename files by prefix and numbers |
| btc-check | Check bitcoin balance by address |
| btc-gen | Generate bitcoin keys and base64 |
| dns-bench | Benchmark DNS servers |
| dns-flush | Flush DNS cache |
| electron | A quick launch for electron apps |
| git-amend | Amend last commit |
| git-clear | Optimize and shrink local .git |
| git-commit | Commit changes |
| git-discard | Discard changes |
| git-init | Initialize a repository |
| git-push | Force push to remote (main/master) |
| git-redo | Commit and squash (redo last commit) |
| git-reset | Reset a repository |
| git-revert | Revert commits to commit-hash |
| git-squash | Squash multiple commits |
| glances | A quick launch for glances (python) |
| gnome-debloat | A tiny debloater for GNOME |
| hex-dump | Hex viewer in hex+ASCII format |
| http-server | Simple file server with subdirectories |
| http-upload | Simple file upload/download server |
| hf-download | Download a HuggingFace repository |
| img-convert | Convert image format using imagemagick |
| img-resize | Resize by size/percent using imagemagick |
| keygen-ssh | Generate ed25519 and rsa-4096 keys |
| keygen-ssl | Generate rsa-4096 cert and key |
| mdx | [mental-diffusion core](https://github.com/nimadez/mental-diffusion) |
| meta-rm | Remove metadata from files and images |
| meta-vu | View metadata in files and images |
| net-block | Run a command without internet access |
| net-dump | A quick tcpdump network traffic monitor |
| net-interface | Edit and update /etc/network/interfaces |
| net-top | A quick iftop network traffic monitor |
| npm-download | Download module to the current directory (wine) |
| nv-watch | Watch nvidia-smi information |
| ollama | Run ollama server with llama 3.1 locally |
| proxy-catcher | Scrap fresh proxies across the web |
| purge | Clean home and apt packages |
| purge-hard | Clean home, purge ~/.cache and temporary files |
| purge-python | Purge pycache of all subdirectories |
| python-make | Make python3 from source |
| screensaver | A windows-style blank screensaver |
| speak-file | Speaks the text file with a female voice |
| speak | Speaks the text input with a female voice |
| speedtest | Get and run speedtest-cli |
| swap-make | Make swap file and mount for next boot |
| unrar | Unrar archive with support for password (wine) |
| term-rec | Record borderless gnome-terminal window |
| venv-activate | Activate a venv by name |
| venv-create | Create a new venv in ~/.venv |
| vlcc | Start vlc in terminal with curses interface |
| xspf-checker | Check xspf playlist for broken links |
| zcolor | A very simple color picker using Zenity |

</details>

<details>
<summary>
🔷&nbsp;&nbsp;<b>GNOME 46 Extensions</b>
</summary>&nbsp;

| Extension | Description |
| ------- | --- |
| panel-hwinfo@nimadez | Add hardware info and transparency to panel<br>CPU and temperature, GPU temp. and fan speed, used mem and swap<br>![hwinfo](media/screenshot.png) |

</details>

## FAQ
How to install Debian 13 with GNOME core desktop?
```
0- [Disable secure boot] (optional, but you have to sign the drivers manually)
   $ sudo mokutil --disable-validation
1- [Install minimal debian 12 to start from command-line]
   - do not select "allow login as root" to enable the "sudo" command
   - do not download or install extras, we're going to update the kernel
   $ sudo apt edit-sources    # comment out the "cdrom" line if needed (not for netinst)
2- [Setup networking]
   $ ip link
   $ sudo nano /etc/network/interfaces
   $ sudo service networking restart
3- [Install git and clone repository]
   $ sudo apt install git
   $ git clone https://github.com/nimadez/cli
4- [Select branch and setup sources]
   apt-source-gen.sh          # generate debian sources.list
   $ update && full-upgrade && reboot
5- [Software installation]
   apt-install-headers.sh     # install kernel headers
   apt-install-nvidia.sh      # install nvidia driver, reboot is required (all non-free)
   apt-install-gnome.sh       # minimal gnome-core only, no firefox and games (all free)
   apt-install-free.sh        # install common free software
   gnome-debloat.sh
6- [Finish installation]
   swap-make.sh               # make a swap file if you don't have a swap partition
   purge-hard.sh              # purge ~/.cache if you don't keep permanent files there

apt-list installed
apt-list contrib
apt-list non-free
apt-list non-free-firmware
apt-list i386

* If you select 5 in step 4, you will get Trixie in the testing branch and the GNOME 46
* It is recommended to delete all caches and temporary files frequently
* Remember to reinstall kernel headers after every kernel update
* The above has been updated in reinstallation on Aug-6-2024
```
How to run these scripts system wide?
```
sh install.sh
* This will symlink scripts to "/usr/local/bin" and remove extensions.
```
What kinds of Generative-AI tools are included?
```
- hf-download (download huggingface repository by repo_id)
- mdx (mental-diffusion core, txt2img, img2img, inpaint)
- mdx-caption (transformers image captioning)
- mdx-detect (transformers object detection)
- mdx-outpaint (create outpaint image and mask for inpaint)
- mdx-upscale (realesrgan upscaler x2 and x4 plus)
- mdx-sd (mdx with sd checkpoint)
- mdx-xl (mdx with xl checkpoint)
- ollama (global generator module with tts support)
- ollama-gram (check grammar, summarize and rewrite)
```
Why is the script not working?
```
There are no binary or model files in this repository,
you have to download, install or even compile the required
software yourself, the necessary explanations are given in
each file separately if needed.
```

## History
```
↑ Debian assistant with AI support
↑ Q1 2024 - Migrating to debian linux after 30 years of ms-dos/win32
↑ Created in 2019 for system automation on windows machine

"A machine can reprogram another machine from scratch."
```

## License
Code released under the [GPL-3.0 license](https://github.com/nimadez/cli/blob/main/LICENSE).
