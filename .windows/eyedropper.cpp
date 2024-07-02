/*
    windres resources.rc -o resources.o
    g++ eyedropper.cpp resources.o -o eyedropper.exe -lcomctl32 -mwindows

    [Application.manifest]
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
        <assemblyIdentity version="1.0.0.0" processorArchitecture="*" name="nimadez.eyedropper" type="win32" />
        <description>A basic color eyedropper</description>
        <dependency>
            <dependentAssembly>
                <assemblyIdentity type="win32" name="Microsoft.Windows.Common-Controls" version="6.0.0.0" processorArchitecture="*" publicKeyToken="6595b64144ccf1df" language="*" />
            </dependentAssembly>
        </dependency>
    </assembly>

    [resources.rc]
    1 24 "Application.manifest"
 */

#include <windows.h>
#include <gdiplus.h>
#include <iostream>
#include <strsafe.h>
#include <commctrl.h>
// console
#include <stdio.h>
#include <io.h>
#include <fcntl.h>


#define IDC_EDIT 10
#define IDC_COLOR 20
#define IDC_HEX 30
#define IDC_RGB_INT 32
#define IDC_RGB_FLOAT 34


LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);
COLORREF ShowColorDialog(HWND hwnd, COLORREF color);
void setTextEditValue(HWND hwnd, HWND hwndEdit, COLORREF color);
void setColorValue(HWND hwnd, HWND hwndEdit, COLORREF color);

FILE* conin = stdin;
FILE* conout = stdout;
FILE* conerr = stderr;
HINSTANCE g_hinst;
COLORREF color = RGB(255, 255, 255);
bool isCapture = false;


int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
    INITCOMMONCONTROLSEX icex; // enable visual styles
	icex.dwSize = sizeof(INITCOMMONCONTROLSEX);
	icex.dwICC = ICC_STANDARD_CLASSES;
	InitCommonControlsEx(&icex);

    MSG  msg;
    WNDCLASSW wc = {0};
    wc.lpszClassName = L"Eyedropper";
    wc.hInstance     = hInstance;
    wc.hbrBackground = GetSysColorBrush(COLOR_3DFACE);
    wc.lpfnWndProc   = WndProc;
    wc.hCursor       = LoadCursor(0, IDC_ARROW);
    wc.style         = CS_HREDRAW | CS_VREDRAW;

    g_hinst = hInstance;

    RegisterClassW(&wc);
    CreateWindowW(wc.lpszClassName, L"Eyedropper",
                WS_VISIBLE | WS_EX_TOPMOST | WS_OVERLAPPED | WS_MINIMIZEBOX | WS_SYSMENU,
                200, 200, 200, 85, 0, 0, hInstance, 0);

    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

   return (int) msg.wParam;
}


LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    static HWND hwndEdit;
    HWND hwndButtonColorDialog;
    HWND hwndRadioHex, hwndRadioInt, hwndRadioFloat;

    POINT mouse;
    RECT rect = { 5, 5, 60, 27 };
    HFONT hFont;

    HDC hdc;
    PAINTSTRUCT ps;
    HBRUSH hBrush, holdBrush;
    HGDIOBJ hPen, holdPen;

    switch(msg)  {
        case WM_CREATE:
            //AllocConsole(); // enable debug console
            //AttachConsole(ATTACH_PARENT_PROCESS);
            //freopen_s(&conin, "conin$", "r", stdin);
            //freopen_s(&conout, "conout$", "w", stdout);
            //freopen_s(&conout, "conout$", "w", stderr);

            SetWindowPos(hwnd, HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE | SWP_NOSIZE); // always on top

            hwndEdit = CreateWindowW(L"Edit", L"#000000", ES_READONLY | WS_CHILD | WS_VISIBLE | WS_BORDER | ES_CENTER | ES_WANTRETURN, 65, 5, 120, 22, hwnd, (HMENU) IDC_EDIT, g_hinst, NULL);
            hwndButtonColorDialog = CreateWindowW(L"button", L"EDIT", WS_VISIBLE | WS_CHILD , 5, 30, 55, 20, hwnd, (HMENU) IDC_COLOR, g_hinst, NULL);
            hwndRadioHex = CreateWindowW(L"Button", L"HEX", WS_CHILD | WS_VISIBLE | BS_AUTORADIOBUTTON, 65, 30, 40, 20, hwnd, (HMENU) IDC_HEX, g_hinst, NULL);
            hwndRadioInt = CreateWindowW(L"Button", L"INT", WS_CHILD | WS_VISIBLE | BS_AUTORADIOBUTTON, 109, 30, 40, 20, hwnd, (HMENU) IDC_RGB_INT, g_hinst, NULL);
            hwndRadioFloat = CreateWindowW(L"Button", L"FLT", WS_CHILD | WS_VISIBLE | BS_AUTORADIOBUTTON, 150, 30, 40, 20, hwnd, (HMENU) IDC_RGB_FLOAT, g_hinst, NULL);
            SendMessage(hwndRadioHex, BM_SETCHECK, IDC_HEX, TRUE); // select hex as default

            hFont = CreateFont(17, 0, 0, 0, FW_DONTCARE, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_SWISS, TEXT("Tahoma"));
            SendMessage(hwndEdit, WM_SETFONT, LPARAM(hFont), TRUE);
            hFont = CreateFont(12, 0, 0, 0, FW_DONTCARE, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_SWISS, TEXT("Tahoma"));
            SendMessage(hwndButtonColorDialog, WM_SETFONT, LPARAM(hFont), TRUE);
            SendMessage(hwndRadioHex, WM_SETFONT, LPARAM(hFont), TRUE);
            SendMessage(hwndRadioInt, WM_SETFONT, LPARAM(hFont), TRUE);
            SendMessage(hwndRadioFloat, WM_SETFONT, LPARAM(hFont), TRUE);
            break;

        case WM_COMMAND:
            if (LOWORD(wParam) == IDC_COLOR) {
                color = ShowColorDialog(hwnd, color);
                setTextEditValue(hwnd, hwndEdit, color);
                InvalidateRect(hwnd, &rect, TRUE);
            }
            if (HIWORD(wParam) == BN_CLICKED) {
                setTextEditValue(hwnd, hwndEdit, color);
            }
            break;
            
        case WM_LBUTTONDOWN:
            isCapture = true;
            SetCapture(hwnd);
            break;

        case WM_LBUTTONUP:
            ReleaseCapture();
            isCapture = false;
            break;

        case WM_CAPTURECHANGED:
            isCapture = (HWND)lParam == hwnd;
            break;

        case WM_MOUSEMOVE:
            if (isCapture) {
                GetCursorPos(&mouse);
                color = GetPixel(GetDC(GetDesktopWindow()), mouse.x, mouse.y);
                setTextEditValue(hwnd, hwndEdit, color);
                InvalidateRect(hwnd, &rect, TRUE);
            }
            break;

        case WM_PAINT:
            hdc = BeginPaint(hwnd, &ps);
            hBrush = CreateSolidBrush(color);
            hPen = CreatePen(PS_NULL, 1, RGB(0, 0, 0));
            holdPen = SelectObject(hdc, hPen);
            holdBrush = (HBRUSH) SelectObject(hdc, hBrush);
            
            Rectangle(hdc, 5, 5, 60, 27);
            FrameRect(hdc, &rect, CreateSolidBrush(RGB(80,80,80)));

            SelectObject(hdc, holdBrush);
            SelectObject(hdc, holdPen);
            DeleteObject(hPen);
            DeleteObject(hBrush);
            EndPaint(hwnd, &ps);
            ReleaseDC(NULL, hdc);
            break;

        case WM_KEYDOWN:
            break;

        case WM_DESTROY:
            FreeConsole();
            PostQuitMessage(0);
            break;
    }

    return DefWindowProcW(hwnd, msg, wParam, lParam);
}


COLORREF ShowColorDialog(HWND hwnd, COLORREF color) {
    CHOOSECOLOR cc;
    static COLORREF crCustClr[16];
    ZeroMemory(&cc, sizeof(cc));
    cc.lStructSize = sizeof(cc);
    cc.hwndOwner = hwnd;
    cc.lpCustColors = (LPDWORD) crCustClr;
    cc.rgbResult = color;
    cc.Flags = CC_FULLOPEN | CC_RGBINIT;
    ChooseColor(&cc);
    return cc.rgbResult;
}


void setTextEditValue(HWND hwnd, HWND hwndEdit, COLORREF color) {
    wchar_t buffer[50];
    if (SendDlgItemMessage(hwnd, IDC_HEX, BM_GETCHECK, 0, 0) == 1) {
        StringCbPrintfW(buffer, (sizeof(buffer)/sizeof(*buffer)), L"#%02X%02X%02X", GetRValue(color), GetGValue(color), GetBValue(color));
    }
    if (SendDlgItemMessage(hwnd, IDC_RGB_INT, BM_GETCHECK, 0, 0) == 1) {
        StringCbPrintfW(buffer, (sizeof(buffer)/sizeof(*buffer)), L"%d, %d, %d", GetRValue(color), GetGValue(color), GetBValue(color));
    }
    if (SendDlgItemMessage(hwnd, IDC_RGB_FLOAT, BM_GETCHECK, 0, 0) == 1) {
        StringCbPrintfW(buffer, (sizeof(buffer)/sizeof(*buffer)), L"%.2f, %.2f, %.2f", GetRValue(color) / 255.0F, GetGValue(color) / 255.0F, GetBValue(color) / 255.0F);
    }
    SetWindowTextW(hwndEdit, buffer);
}
