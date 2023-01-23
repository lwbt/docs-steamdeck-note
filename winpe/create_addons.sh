#!/bin/bash

# Create directory structure.
#mkdir -pv \
#  "build/Program Files/"{"KeePassXC","Meld","Mozilla Firefox","mpv","Neovim","PowerShell-7-win-x64","TreeSize Free","WindowsPowerShell"}
mkdir -pv \
  "build/Program Files/"{"KeePassXC","mpv","Neovim","PowerShell-7-win-x64","TreeSize Free","WindowsPowerShell"}
mkdir -pv "build/Program Files (x86)"
mkdir -pv "build/Users/Default/AppData"
mkdir -pv "build/Users/Default/Documents/PowerShell"
mkdir -pv "build/Windows/"{"System32","WinSxS"}
mkdir -pv "build/Windows/Web/Wallpaper/Windows"
mkdir -pv "cache"

mkdir -pv "build/Users/Default/AppData/Roaming/Mozilla/Firefox/Profiles/m3iau0kd.default-release"

# Copy assets.
cp -v "assets/HBCD_PE_dark.jpg" \
  "build/Windows/Web/Wallpaper/Windows/HBCD_PE.jpg"
cp -v "assets/pecmd.ini" \
  "build/Windows/System32/pecmd.ini"
cp -v "assets/Microsoft.PowerShell_profile.ps1" \
  "build/Users/Default/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
## Mozilla Firefox
cp -v "assets/mozilla/installs.ini" \
  "build/Users/Default/AppData/Roaming/Mozilla/Firefox/"
cp -v "assets/mozilla/profiles.ini" \
  "build/Users/Default/AppData/Roaming/Mozilla/Firefox/"
cp -v "assets/mozilla/extensions.json" \
  "build/Users/Default/AppData/Roaming/Mozilla/Firefox/Profiles/m3iau0kd.default-release/"
cp -v "assets/mozilla/prefs.js" \
  "build/Users/Default/AppData/Roaming/Mozilla/Firefox/Profiles/m3iau0kd.default-release/"

# TODO: Only download when files are not present of a newer version exists.
## Download programs - deliberately hard coded for now, worray about the complexity of each item later
## Meld
#wget --output-document="cache/Meld-mingw.msi" \
#  "https://download.gnome.org/binaries/win32/meld/3.22/Meld-3.22.0-mingw.msi"
## Mozilla Firefox
#wget --output-document="cache/Firefox_en-US.msi" \
#  "https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=en-US"
##wget --output-document="cache/Firefox.exe" \
##  "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
## mpv
#wget --output-document="cache/mpv-x86_64.7z" \
#  "https://altushost-swe.dl.sourceforge.net/project/mpv-player-windows/64bit/mpv-x86_64-20230122-git-92a6f2d.7z"
## Neovim
#wget --output-document="cache/nvim-win64.zip" \
#  "https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-win64.zip"
## PowerShell
#wget --output-document="cache/PowerShell-win-x64.zip" \
#  "https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/PowerShell-7.3.1-win-x64.zip"
## TreeSize Free
#wget --output-document="cache/TreeSizeFree-Portable.zip" \
#  "https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip"

# Extract programs.
mkdir -pv \
  "cache/"{"TreeSizeFree-Portable","Meld-mingw","Firefox","nvim-win64","mpv-x86_64","PowerShell-win-x64"}

# TODO: How to extract an MSI? It can be done on Windows!
#7z x "cache/Meld-mingw.msi" \
#  -o"cache/Meld-mingw"
#mv "cache/Meld-mingw" \
#  "build/Program Files/Meld"
cp -a "cache/Meld" \
  "build/Program Files/Meld"

#7z x "cache/Firefox_en-US.msi" \
#  -o"cache/Firefox"
#mv "cache/Firefox" \
#  "build/Program Files/Mozilla Firefox"
cp -a "cache/Mozilla Firefox" \
  "build/Program Files/Mozilla Firefox"

7z x "cache/mpv-x86_64.7z" \
  -o"cache/mpv-x86_64"
mv "cache/mpv-x86_64/"* \
  "build/Program Files/mpv/"

7z x "cache/nvim-win64.zip" \
  -o"cache/nvim-win64"
mv "cache/nvim-win64/nvim-win64/"* \
  "build/Program Files/Neovim/"

7z x "cache/PowerShell-win-x64.zip" \
  -o"cache/PowerShell-win-x64"
mv "cache/PowerShell-win-x64/"* \
  "build/Program Files/PowerShell-7-win-x64/"

7z x "cache/TreeSizeFree-Portable.zip" \
  -o"cache/TreeSizeFree-Portable"
mv "cache/TreeSizeFree-Portable/"* \
  "build/Program Files/TreeSize Free"

rm -Rv \
  "cache/"{"TreeSizeFree-Portable","Meld-mingw","Firefox","nvim-win64","mpv-x86_64","PowerShell-win-x64"}

# Copy msvcp140 from Firefox to Neovim.
cp "build/Program Files/Mozilla\ Firefox/msvcp140.dll" \
  "build/Program\ Files/Neovim/bin/"
cp "build/Program Files/Mozilla\ Firefox/msvcp140.dll" \
  "build/Program\ Files/Neovim/bin/"

# This is ugly, more research required.
cd "build/" || exit 1
7z a -mx9 "../HBCD_addons_test.7z" *
cd - || exit 1
