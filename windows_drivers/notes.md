# GPU
GPU\setup.exe

# SD card
#Sdcard\setup.exe /r
Sdcard\setup.exe /s

# Audio Divers
Get-ChildItem "Audio\" -Recurse -Filter "*inf" | ForEach-Object { PNPUtil.exe /add-driver $_.FullName /install }

# RTL Blue
Blue\InstallDriver.cmd

# RTL WLAN
WLAN\Install.bat

# Controller input driver
SWICD_Setup.exe /S
