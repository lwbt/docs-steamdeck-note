#!/bin/bash

IMAGE="HBCD_PE_x64.iso"
BASE_NAME="$(basename -s ".iso" "${IMAGE}")"
REMOVAL_LIST="removal_list.txt"

7z x "${IMAGE}" -o"${BASE_NAME}"

rm -r \
  "${BASE_NAME}/Programs/Acronis True Image" \
  "${BASE_NAME}/Programs/Acrylic Wi-Fi Home" \
  "${BASE_NAME}/Programs/Aero Admin" \
  "${BASE_NAME}/Programs/AOMEI Backupper" \
  "${BASE_NAME}/Programs/AOMEI Partition Assistant" \
  "${BASE_NAME}/Programs/Crystal Disk Info" \
  "${BASE_NAME}/Programs/Defraggler" \
  "${BASE_NAME}/Programs/Dependency Walker" \
  "${BASE_NAME}/Programs/DiskGenius" \
  "${BASE_NAME}/Programs/DMDE" \
  "${BASE_NAME}/Programs/EaseUS Partition Master" \
  "${BASE_NAME}/Programs/Eraser" \
  "${BASE_NAME}/Programs/ESET Online Scanner" \
  "${BASE_NAME}/Programs/ExamDiff Pro" \
  "${BASE_NAME}/Programs/FSViewer.lnk" \
  "${BASE_NAME}/Programs/Google Chrome" \
  "${BASE_NAME}/Programs/GPU-Z" \
  "${BASE_NAME}/Programs/GSmartControl" \
  "${BASE_NAME}/Programs/HDDLLF" \
  "${BASE_NAME}/Programs/HDDScan.lnk" \
  "${BASE_NAME}/Programs/HDTune" \
  "${BASE_NAME}/Programs/HWInfo" \
  "${BASE_NAME}/Programs/Kaspersky Virus Removal Tool" \
  "${BASE_NAME}/Programs/Lazesoft Recovery Suite.lnk" \
  "${BASE_NAME}/Programs/Macrium Reflect" \
  "${BASE_NAME}/Programs/Macrorit Partition Expert.lnk" \
  "${BASE_NAME}/Programs/Macrorit Partition Extender.lnk" \
  "${BASE_NAME}/Programs/Malwarebytes Anti-Malware" \
  "${BASE_NAME}/Programs/McAfee Stinger" \
  "${BASE_NAME}/Programs/Mozilla Firefox" \
  "${BASE_NAME}/Programs/Notepad++.lnk" \
  "${BASE_NAME}/Programs/Puran Data Recovery" \
  "${BASE_NAME}/Programs/Puran File Recovery" \
  "${BASE_NAME}/Programs/ReclaiMe Free RAID Recovery" \
  "${BASE_NAME}/Programs/Recuva" \
  "${BASE_NAME}/Programs/Rufus" \
  "${BASE_NAME}/Programs/SoftMaker FreeOffice" \
  "${BASE_NAME}/Programs/Speccy" \
  "${BASE_NAME}/Programs/SumatraPDF" \
  "${BASE_NAME}/Programs/Unstoppable Copier" \
  "${BASE_NAME}/Programs/VLC Media Player" \
  "${BASE_NAME}/Programs/WesternDigital" \
  "${BASE_NAME}/Programs/WinMerge" \
  "${BASE_NAME}/Programs/WordPad" \
  "${BASE_NAME}/Programs/FSViewer.lnk" \
  "${BASE_NAME}/Programs/HDDScan.lnk" \
  "${BASE_NAME}/Programs/Lazesoft Recovery Suite.lnk" \
  "${BASE_NAME}/Programs/Macrorit Partition Expert.lnk" \
  "${BASE_NAME}/Programs/Macrorit Partition Extender.lnk" \
  "${BASE_NAME}/Programs/Notepad++.lnk" \
  "${BASE_NAME}/Programs/PowerShell Core_x64"

  # We saved enough space, keeing functional menus seems reasonable now.
  #"${BASE_NAME}/Programs/WinXShell"

# The functionality to delete files from an archive is called with and include
# list which includes the files which should be deleted. No wonder why I have
# been pulling my hair out many years ago.
7z d -i@"${REMOVAL_LIST}" "${BASE_NAME}/sources/boot.wim"

# Can squire out ~100MB.
wimoptimize \
  --recompress \
  --compress=LZX:100 \
  "${BASE_NAME}/sources/boot.wim"

# Probably still relevant, but who cares about eltorito today?
# https://unix.stackexchange.com/a/531407/49853
genisoimage \
  -o "HBCD_PE_x64_stripped.iso" \
  -V "HBCD_PE_x64str" \
  -R \
  -J "HBCD_PE_x64"

