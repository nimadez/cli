//g++ pc-control.cpp -o pc-control.exe
#include <iostream>
#include <windows.h>


const char *help =
    "pc-control getmouse\n" // return mouse position
    "pc-control setmouse x y\n" // set absolute mouse position
    "pc-control mouse x y\n" // set relative mouse position
    "pc-control click [left, right, middle] 1\n" // mouse click (2=double)
    "pc-control wheel [up, down] 10\n" // mouse wheel (10 steps)
    "pc-control key [space,enter,left,right,up,down,escape,f4,f5,f11,/,-,tab,backspace,win]\n"
    "pc-control type \"String 09 AZ az\"\n"
    "pc-control volume [up, down, mute]\n"
    "pc-control shutdown [monitor, sleep, shutdown]";


POINT getMousePos() {
    POINT p = {0,0};
    GetCursorPos(&p);
    return p;
}

void mouseMove(int x, int y) {
    SetCursorPos(x, y);
}

void mouseClickLeft() {
    mouse_event(0x0002, 0, 0, 0, 0);  // press
    mouse_event(0x0004, 0, 0, 0, 0);  // release
}

void mouseClickRight() {
    mouse_event(0x0008, 0, 0, 0, 0);
    mouse_event(0x0010, 0, 0, 0, 0);
}

void mouseClickMiddle() {
    mouse_event(0x0020, 0, 0, 0, 0);
    mouse_event(0x0040, 0, 0, 0, 0);
}

void mouseWheel(int step) { // -step for wheel down
    mouse_event(MOUSEEVENTF_WHEEL, 0, 0, step, 0);
}

void keyAction(int code) {
    keybd_event(code, 0, 0, 0);   // press
    keybd_event(code, 0, 0x2, 0); // release
}

void keyType(const char *str) { // 09 AZ az
    char ch;
    int key;
    while (ch = *str++) {
        if (isupper(ch)) {
            key = ch;
            keybd_event(VK_SHIFT, 0, 0, 0);
            keyAction(key);
            keybd_event(VK_SHIFT, 0, 0x2, 0);
        } else {
            key = toupper(ch);
            keyAction(key);
        }
    }
}

void volumeUp(HWND hwnd) {
    SendMessageA(hwnd, WM_APPCOMMAND, 0, APPCOMMAND_VOLUME_UP * 0x10000);
}

void volumeDown(HWND hwnd) {
    SendMessageA(hwnd, WM_APPCOMMAND, 0, APPCOMMAND_VOLUME_DOWN * 0x10000);
}

void volumeMute(HWND hwnd) {
    SendMessageA(hwnd, WM_APPCOMMAND, 0, APPCOMMAND_VOLUME_MUTE * 0x10000);
}

void monitorOff(HWND hwnd) {
    SendMessageA(hwnd, WM_SYSCOMMAND, SC_MONITORPOWER, 2);
}

void sleep() {
    system("rundll32.exe powrprof.dll,SetSuspendState Sleep");
}

void shutdown() {
    system("shutdown.exe /s /f");
}


int main(int argc, char* argv[])
{
    if (argc <= 1) {
        printf(help);
        return -1;
    }

    std::string action = argv[1];
    std::string value1;
    std::string value2;
    if (argc == 3) { value1 = argv[2]; }
    if (argc == 4) { value1 = argv[2]; value2 = argv[3]; }

    if (action == "getmouse") {
        POINT p = getMousePos();
        printf("%d,%d", p.x, p.y);
    }
    
    else if (action == "setmouse") {
        mouseMove(std::stoi(value1), std::stoi(value2));
    }

    else if (action == "mouse") {
        POINT p = getMousePos();
        mouseMove(p.x + std::stoi(value1), p.y + std::stoi(value2));
    }

    else if (action == "click") {
        if (value1 == "left") {
            for (int i=0; i<std::stoi(value2); i++) { mouseClickLeft(); }
        } else if (value1 == "right") {
            mouseClickRight();
        } else if (value1 == "middle") { 
            mouseClickMiddle();
        }
    }

    else if (action == "wheel") {
        if (value1 == "up") {
            mouseWheel(std::stoi(value2));
        } else if (value1 == "down") {
            mouseWheel(-std::stoi(value2));
        }
    }

    else if (action == "key") {
        if (value1 == "space")          keyAction(VK_SPACE);
        else if (value1 == "enter")     keyAction(VK_RETURN);
        else if (value1 == "left")      keyAction(VK_LEFT);
        else if (value1 == "right")     keyAction(VK_RIGHT);
        else if (value1 == "up")        keyAction(VK_UP);
        else if (value1 == "down")      keyAction(VK_DOWN);
        else if (value1 == "escape")    keyAction(VK_ESCAPE);
        else if (value1 == "f4")        keyAction(VK_F4);
        else if (value1 == "f5")        keyAction(VK_F5);
        else if (value1 == "f11")       keyAction(VK_F11);
        else if (value1 == "/")         keyAction(VK_DIVIDE);
        else if (value1 == "-")         keyAction(VK_OEM_MINUS);
        else if (value1 == "tab")       keyAction(VK_TAB);
        else if (value1 == "backspace") keyAction(VK_BACK);
        else if (value1 == "win")       keyAction(VK_LWIN);
    }

    else if (action == "type") {
        keyType(value1.c_str());
    }

    else if (action == "volume") {
        if (value1 == "up") volumeUp(GetConsoleWindow());
        else if (value1 == "down") volumeDown(GetConsoleWindow());
        else if (value1 == "mute") volumeMute(GetConsoleWindow());
    }
    
    else if (action == "shutdown") {
        if (value1 == "monitor") monitorOff(GetConsoleWindow());
        else if (value1 == "sleep") sleep();
        else if (value1 == "shutdown") shutdown();
    }

    else {
        printf(help);
        return -1;
    }

    return 0;
}
