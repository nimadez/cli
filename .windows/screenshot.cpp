//g++ screenshot.cpp -o screenshot.exe -lgdi32 -lgdiplus
#include <time.h>
#include <windows.h>
#include <gdiplus.h>
#include <iostream>


int GetEncoderClsid(const WCHAR* format, CLSID* pClsid)
{
    UINT num = 0;  // number of image encoders
    UINT size = 0; // size of the image encoder array in bytes

    Gdiplus::ImageCodecInfo* pImageCodecInfo = NULL;

    Gdiplus::GetImageEncodersSize(&num, &size);
    if (size == 0) return -1;

    pImageCodecInfo = (Gdiplus::ImageCodecInfo*)(malloc(size));
    if (pImageCodecInfo == NULL) return -1;

    Gdiplus::GetImageEncoders(num, size, pImageCodecInfo);

    for (UINT i = 0; i < num; ++i) {
        if (wcscmp(pImageCodecInfo[i].MimeType, format) == 0) {
            *pClsid = pImageCodecInfo[i].Clsid;
            free(pImageCodecInfo);
            return i;
        }
    }

    free(pImageCodecInfo);
    return -1;
}


void GetScreenshot(const int x, const int y, int W, int H, const char* path) {
    Gdiplus::GdiplusStartupInput gdiplusStartupInput;
    ULONG_PTR gdiplusToken;
    Gdiplus::GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL);

    if (W == 0) { W = GetSystemMetrics(SM_CXSCREEN); }
    if (H == 0) { H = GetSystemMetrics(SM_CYSCREEN); }

    HDC hdc = GetDC(NULL);
    HDC hDest = CreateCompatibleDC(hdc);

    HBITMAP hbDesktop = CreateCompatibleBitmap(hdc, W, H);

    SelectObject(hDest, hbDesktop);                 // use the previously created device context with the bitmap
    BitBlt(hDest, 0, 0, W, H, hdc, x, y, SRCCOPY);  // copy from the desktop device context to the bitmap device context

    Gdiplus::Bitmap bitmap(hbDesktop, NULL);
    CLSID clsid;
    size_t size = strlen(path) + 1;
    wchar_t* pathName = new wchar_t[size];
    size_t outSize;
    mbstowcs_s(&outSize, pathName, size, path, size - 1);
    GetEncoderClsid(L"image/png", &clsid);
    bitmap.Save(pathName, &clsid, NULL);

    ReleaseDC(NULL, hdc);
    DeleteObject(hbDesktop);
    DeleteDC(hDest);

    Gdiplus::GdiplusShutdown(gdiplusToken);
}


void GetFixedScreenshot(const char* path, bool border) {
    WINDOWINFO info;
    if (GetWindowInfo(GetForegroundWindow(), &info)) {
        RECT rect;
        UINT cxBorder = 0;
        UINT cyBorder = 0;
        
        if (border == false) {
            rect = info.rcClient; //no border
        } else {
            rect = info.rcWindow; //w border and title
        }
        
        int width  = rect.right - rect.left;
        int height = rect.bottom - rect.top;
        GetScreenshot(rect.left, rect.top, width, height, path);
    }
}


int main(int argc, char* argv[])
{
    printf( "1. Select A Window\n"
            "2. Press <CTRL> to capture borderless (native windows only)\n"
            "3. Press <SHIFT> to capture title, border and shadow\n"
            "Press <ESCAPE> to exit\n");

    srand(time(NULL));
    int number = rand() % 9000 + 1000;
    char fileName[sizeof(char)];
    std::sprintf(fileName, "screenshot_%d.png", number);

    while (1) {
        if (GetKeyState(VK_CONTROL) < 0) {
            GetFixedScreenshot(fileName, false);
            break;
        }
        if (GetKeyState(VK_SHIFT) < 0) {
            GetFixedScreenshot(fileName, true);
            break;
        }
        if (GetKeyState(VK_ESCAPE) < 0) {
            break;
        }
    }

    return 0;
}
