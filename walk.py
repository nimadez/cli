#!/usr/bin/env python3
#
# WALKER 300 - TUI file browser (x11/wayland)
#
# - Fast and simple in 300 lines of human-readable code with no dependencies
# - Correct sorting and no reading problems
# - It takes care of all sorts of conditions, it can even browse the /proc directory
# - Records and retrieves walking history
# - Edit with (sudo) nano, watch changes, view hex dump, and execute files
# - Debian terminal compliant and resizable


import os, subprocess, signal, curses


os.environ['ESCDELAY'] = "60"
os.environ['TERM'] = "xterm-256color"

DENIED_DIRS = [ "<Empty Directory>", "<Permission Denied>", "<Deleted Path>" ]
BINARY_EXTS = { '.bin', '.exe', '.o', '.so', '.pyc', '.jpg', '.png', '.gif', '.bmp', '.hdr', '.webp', '.pdf', '.zip', '.rar', '.tar', '.tar.xz', '.tar.gz', '.gz', '.xz', '.mp3', '.acc', '.mp4', '.avi', '.mov', '.webm' }
HELP = "←↓↑→:Nav|e:Edit|w:Watch|x:Hex|Enter:Run|q/Esc:Quit  "


def setColors():
    curses.start_color()
    curses.use_default_colors()
    curses.init_pair(1, curses.COLOR_WHITE, -1)
    curses.init_pair(11, 8, -1)  # bright
    curses.init_pair(12, curses.COLOR_WHITE, curses.COLOR_BLUE)
    curses.init_pair(3, curses.COLOR_CYAN, -1)
    curses.init_pair(31, 6, -1)  # bright
    curses.init_pair(4, curses.COLOR_MAGENTA, -1)
    curses.init_pair(5, curses.COLOR_GREEN, -1)
    curses.init_pair(51, 10, -1) # bright
    curses.init_pair(6, curses.COLOR_BLUE, -1)
    curses.init_pair(61, curses.COLOR_WHITE, curses.COLOR_BLUE)
    curses.init_pair(7, curses.COLOR_RED, -1)


def is_readable(file_path):
    if os.path.splitext(file_path)[1].lower() in BINARY_EXTS:
        return False

    try:
        with open(file_path, 'rb') as f:
            chunk = f.read(1024)
            if not chunk:
                return True
            chunk.decode('utf-8')
            return True
    except (IOError, OSError, PermissionError, UnicodeDecodeError):
        return False


def is_executable(file_path):
    return os.path.isfile(file_path) and os.access(file_path, os.X_OK)


def truncate_preview(line, max_width): # strip tabs
    return line.expandtabs(4)[:max_width]


def get_preview(file_path, max_lines, max_width):
    if not os.path.exists(file_path):
        return [DENIED_DIRS[2]]

    try:
        if os.path.isdir(file_path):
            os.listdir(file_path)
    except PermissionError:
        return [DENIED_DIRS[1]]

    if os.path.isdir(file_path):
        return [f"Directory of {len(os.listdir(file_path))} items"]

    if not is_readable(file_path):
        return ["<Binary File>"]

    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            lines = [truncate_preview(line, max_width) for line in f.readlines()[:max_lines]]
            return lines if lines else ["<Empty File>"]
    except:
        return ["<Error Reading File>"]


def main(stdscr):
    stdscr.timeout(100)
    curses.curs_set(0)
    curses.noecho()
    curses.cbreak()
    setColors()
    
    current_dir = os.getcwd()
    files = []
    selected = 0
    scroll_offset = 0
    walk_history = [(current_dir, 0, 0)]
    show_help = False

    def refresh_list():
        nonlocal files
        nonlocal current_dir

        if not os.path.exists(current_dir):
            files = [DENIED_DIRS[2]]
            return

        try:
            if os.path.isdir(current_dir):
                os.listdir(current_dir)
        except PermissionError:
            files = [DENIED_DIRS[1]]
            return

        items = os.listdir(current_dir)
        sorted_dirs = [item for item in items if os.path.isdir(os.path.join(current_dir, item)) and not item.startswith(".")]
        sorted_dirs_dot = [item for item in items if os.path.isdir(os.path.join(current_dir, item)) and item.startswith(".")]
        sorted_files = [item for item in items if os.path.isfile(os.path.join(current_dir, item))]
        sorted_dirs.sort(key=str.lower)
        sorted_dirs_dot.sort(key=str.lower)
        sorted_files.sort(key=str.lower)
        
        files = sorted_dirs + sorted_dirs_dot + sorted_files
        if not files:
            files = [DENIED_DIRS[0]]
    
    while True:
        height, width = stdscr.getmaxyx()
        half_width = width // 2
        max_lines = stdscr.getmaxyx()[0] - 4

        stdscr.erase()
        refresh_list()
        
        # Title Bar
        stdscr.addstr(0, 0, " " * width, curses.color_pair(61))
        if not show_help:
            stdscr.addstr(0, 0, "  WALKER 300", curses.color_pair(61))
            stdscr.addstr(0, width - 8, "h:Help", curses.color_pair(12))
        else:
            stdscr.addstr(0, 0, "  WALKER 300 @nimadez", curses.color_pair(61))
            stdscr.addstr(0, width - len(HELP), HELP, curses.color_pair(12))

        # Content
        stdscr.addstr(2, 2, f"${current_dir}"[:width - 4], curses.color_pair(4))

        for i in range(3, height - 1):
            stdscr.addstr(i, half_width - 4, "|", curses.color_pair(11))

        for i in range(max_lines):
            if i + scroll_offset >= len(files):
                break
                
            file_name = files[i + scroll_offset]
            file_path = os.path.join(current_dir, file_name) if file_name not in DENIED_DIRS else None
            is_dir = file_path and os.path.isdir(file_path)

            # File List
            display_name = file_name[:half_width - 7]
            if file_path and os.path.islink(file_path):
                display_name = file_name[:half_width - 9]
                display_name += " *"

            if i + scroll_offset == selected:
                if file_name not in DENIED_DIRS:
                    stdscr.addstr(i + 3, 0, f"> {display_name}", curses.color_pair(31) | curses.A_BOLD if file_name.startswith(".") else curses.color_pair(31) | curses.A_BOLD)
                else:
                    stdscr.addstr(i + 3, 0, f"> {display_name}", curses.color_pair(7) | curses.A_BOLD)
            else:
                if is_dir:
                    stdscr.addstr(i + 3, 0, f"  {display_name}", curses.color_pair(51) if not file_name.startswith(".") else curses.color_pair(5))
                else:
                    stdscr.addstr(i + 3, 0, f"  {display_name}", curses.color_pair(1) if not file_name.startswith(".") else curses.color_pair(11))
            
            # Preview
            if i + scroll_offset == selected and file_path:
                preview = get_preview(file_path, max_lines, half_width - 1)
                try:
                    for j, line in enumerate(preview):
                        if j >= max_lines:
                            break
                        stdscr.addstr(j + 3, half_width - 1, line, curses.color_pair(1))
                except ValueError:
                    pass

        stdscr.refresh()

        # Events
        key = stdscr.getch()
        
        if key == curses.KEY_RESIZE:
            selected = 0
            scroll_offset = 0
            walk_history = [(current_dir, 0, 0)]

        elif key == curses.KEY_UP:
            selected -= 1
            if selected < 0:
                selected = len(files) - 1
                if len(files) > max_lines:
                    scroll_offset = len(files) - max_lines
                else:
                    scroll_offset = 0
            elif selected < scroll_offset:
                scroll_offset = selected

        elif key == curses.KEY_DOWN:
            selected += 1
            if selected >= len(files):
                selected = 0
                scroll_offset = 0
            elif selected >= scroll_offset + max_lines:
                scroll_offset = selected - max_lines + 1

        elif key == curses.KEY_RIGHT and files[selected] not in DENIED_DIRS:
            selected_path = os.path.join(current_dir, files[selected])
            if os.path.isdir(selected_path):
                current_dir = selected_path
                walk_history.append((current_dir, selected, scroll_offset))
                selected = 0
                scroll_offset = 0

        elif key == curses.KEY_LEFT:
            parent_dir = os.path.dirname(current_dir)
            if parent_dir != current_dir:
                current_dir = parent_dir
                selected = 0
                scroll_offset = 0
                if walk_history:
                    prev_path, prev_selected, prev_scroll = walk_history[-1]
                    if os.path.dirname(prev_path) == parent_dir:
                        selected = prev_selected
                        scroll_offset = prev_scroll
                        del walk_history[-1]
                    else:
                        walk_history[-1] = (current_dir, selected, scroll_offset)
                    
        elif key == curses.KEY_ENTER or key == 10 or key == 13:
            selected_path = os.path.join(current_dir, files[selected])
            if is_executable(selected_path):
                CMD="""#!/bin/bash
                    echo
                    <SRC>
                    read -p "Press enter to exit ..." p
                    """.replace('<SRC>', selected_path)
                curses.endwin()
                subprocess.run(['sh', '-c', CMD])
                stdscr = curses.initscr()
                setColors()
                curses.curs_set(0)

        elif key == ord('e'):
            selected_path = os.path.join(current_dir, files[selected])
            if os.path.isfile(selected_path):
                curses.endwin()
                subprocess.run(['sudo', 'nano', selected_path])
                stdscr = curses.initscr()
                setColors()
                curses.curs_set(0)

        elif key == ord('w'):
            selected_path = os.path.join(current_dir, files[selected])
            if os.path.isfile(selected_path):
                curses.endwin()
                subprocess.run(['watch', '-c', '-n', '1', 'cat', selected_path])
                stdscr = curses.initscr()
                setColors()
                curses.curs_set(0)

        elif key == ord('x'):
            selected_path = os.path.join(current_dir, files[selected])
            if os.path.isfile(selected_path):
                curses.endwin()
                subprocess.run(['sh', '-c', f"hexdump -C '{selected_path}' | less -X"])
                stdscr = curses.initscr()
                setColors()
                curses.curs_set(0)

        elif key == ord('h'):
            show_help = not show_help

        elif key == ord('q') or key == 27:
            break

    curses.nocbreak()
    curses.echo()
    
    return os.path.join(current_dir, files[selected]) if files[selected] not in DENIED_DIRS else current_dir


def signal_handler(signum, frame):
    pass


if __name__ == '__main__':
    signal.signal(signal.SIGINT, signal_handler)
    exit_path = curses.wrapper(main)

    print(f"\n{exit_path}", end="\n", flush=True)
