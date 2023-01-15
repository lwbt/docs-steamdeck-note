# GPU
setup.exe

# SD card
#setup.exe /r
setup.exe /s

# Audio Divers
Get-ChildItem "Audio/" -Recurse -Filter "*inf" | ForEach-Object { PNPUtil.exe /add-driver $_.FullName /install }

# RTL Blue
Blue/InstallDriver.cmd

# RTL WLAN
Install.bat

# Controller input driver
SWICD_Setup.exe /S
