Option Explicit
Dim WSHShell, strSetting
Set WSHShell = WScript.CreateObject("WScript.Shell")

strSetting = wshshell.regread("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable")
If strSetting = 1 Then
Disabled
Else Enabled
End If

Sub Enabled
WSHShell.regwrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable", 1, "REG_DWORD"
WScript.Echo "Proxy is Enabled"
End Sub

Sub Disabled
WSHShell.regwrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable", 0, "REG_DWORD"
WScript.Echo "Proxy is Disabled"
End Sub
